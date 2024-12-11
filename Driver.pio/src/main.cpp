#include <Arduino.h>
#include <Wire.h>

#include "motor-speed-controller.h"

#include "pin-config.h"

// #define DEBUG_MESSAGES

#define FRAME_INTERVAL 50
#define EPISODE_INTERVAL 2000
#define DEBUG_INTERVAL 30

#define INTERRUPTS_PER_REV 6000
#define RPM_K 60000 / INTERRUPTS_PER_REV

#define DEVICE_ID 0x09
#define COMMAND_LENGTH 10
#define COMMAND_SET_SPEED 0x4D
#define COMMAND_SET_PWM 0x50
#define COMMAND_STOP 0x53
#define COMMAND_SET_REGISTER 0xFF

#define DATA_REGISTERY_SIZE 12

volatile byte currentCommand[COMMAND_LENGTH];
volatile int commandCounter = 0;

unsigned long now;
unsigned long frame_time;
unsigned long episode_time;
unsigned long debug_time;

MotorSpeedController motorA(AIN1, AIN2, PWMA, AENC1, AENC2);
MotorSpeedController motorB(BIN1, BIN2, PWMB, BENC1, BENC2);

volatile byte dataRegistery[DATA_REGISTERY_SIZE];
volatile int currentRegister = 0;

int decodeInt(byte char0, byte char1)
{
  return (char0 << 8) + char1;
}

void encodeInt(int input, volatile byte *out0, volatile byte *out1)
{
  *out0 = input >> 8;
  *out1 = input & 0xFF;
}

long decodeLong(byte (&arr)[4])
{
  return ((long)arr[0] << 24) |
         ((long)arr[1] << 16) |
         ((long)arr[2] << 8) |
         (long)arr[3];
}

void encodeLong(long input, volatile byte *out0, volatile byte *out1, volatile byte *out2, volatile byte *out3)
{
  *out0 = (input >> 24) & 0xFF; // Most Significant Byte
  *out1 = (input >> 16) & 0xFF;
  *out2 = (input >> 8) & 0xFF;
  *out3 = input & 0xFF; // Least Significant Byte
}

void on_frame()
{
  motorA.loop();
  motorB.loop();

  // Update the dataRegistery.
  // Registers 0 to 3: MotorA position long encoded as 4 bytes
  // Registers 4 to 7: MotorB position long encoded as 4 bytes
  // Registers 8 to 9: MotorA speed int encoded as 2 bytes
  // Registers 10 to 11: MotorB speed int encoded as 2 bytes

  encodeLong(motorA.getCurrentPosition(),
             dataRegistery + 0,
             dataRegistery + 1,
             dataRegistery + 2,
             dataRegistery + 3);

  encodeLong(motorB.getCurrentPosition(),
             dataRegistery + 4,
             dataRegistery + 5,
             dataRegistery + 6,
             dataRegistery + 7);

  encodeInt(motorA.getCurrentSpeed(),
            dataRegistery + 8,
            dataRegistery + 9);

  encodeInt(motorB.getCurrentSpeed(),
            dataRegistery + 10,
            dataRegistery + 11);
}

void on_episode()
{
  motorA.stop();
  motorB.stop();
}

void reset_episode()
{
  episode_time = millis();
}

void set_steering(int angle, int speed)
{
}

void commandSetSpeed(volatile byte command[COMMAND_LENGTH])
{
  /*  M    255   255   255   255  */
  /*  0x4D 0x00  0x00  0x00  0x00 */
  int motorASpeed = decodeInt(command[2], command[3]);
  int motorBSpeed = decodeInt(command[4], command[5]);

  reset_episode();

  motorA.setPIDSpeed(motorASpeed);
  motorB.setPIDSpeed(motorBSpeed);
}

void commandSetPWM(volatile byte command[COMMAND_LENGTH])
{
  /*  P    255   255   255   255  */
  /*  0x4D 0x00  0x00  0x00  0x00 */
  int motorASpeed = decodeInt(command[2], command[3]);
  int motorBSpeed = decodeInt(command[4], command[5]);

  reset_episode();

  motorA.stopPIDControl();
  motorA.setPWMSpeed(motorASpeed);

  motorB.stopPIDControl();
  motorB.setPWMSpeed(motorBSpeed);
}

void commandStop(volatile byte command[COMMAND_LENGTH])
{
  /*  S   */
  /* 0x53 */

  motorA.stop();
  motorB.stop();
}

void commandSetRegister(volatile byte command[COMMAND_LENGTH])
{
  /*  255  255   */
  /*  0xFF 0x00  */
  if (int(command[2]) > DATA_REGISTERY_SIZE - 1)
  {
    return;
  }
  currentRegister = command[2];
}

void interpretCommand(volatile byte command[COMMAND_LENGTH], int length)
{
  switch (command[1])
  {

  case COMMAND_SET_SPEED:
    commandSetSpeed(command);
    break;

  case COMMAND_SET_PWM:
    commandSetPWM(command);
    break;

  case COMMAND_STOP:
    commandStop(command);
    break;

  case COMMAND_SET_REGISTER:
    commandSetRegister(command);
    break;

  default:
    break;
  }
}

void wireRecieveEvent(int howMany)
{
  byte readBuffer;

  commandCounter = 0;
  while (Wire.available())
  {
    readBuffer = Wire.read();
    if (commandCounter < COMMAND_LENGTH)
    {
      currentCommand[commandCounter] = readBuffer;
      commandCounter++;
    }
  }
  interpretCommand(currentCommand, commandCounter);
}

void wireRequestEvent()
{
  Serial.println(currentRegister);
  Wire.write(dataRegistery[currentRegister]);
}

void setup()
{
  Wire.begin(DEVICE_ID);

  Wire.onReceive(wireRecieveEvent);
  Wire.onRequest(wireRequestEvent);

  // Enable the motor driver
  pinMode(STBY, OUTPUT);
  digitalWrite(STBY, HIGH);

  // Initialize motors
  motorA.setup();
  motorB.setup();

  // Stop the motors
  motorA.stop();
  motorB.stop();

  reset_episode();
}

void loop()
{
  now = millis();
  if (now - frame_time > FRAME_INTERVAL)
  {
    on_frame();
    frame_time = now;
  }

  if (now - episode_time > EPISODE_INTERVAL)
  {
    on_episode();
    reset_episode();
  }

  // Wait a little to ensure i2c bus does not fail
  delay(1);
}

// `6000 int is one rev