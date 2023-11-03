#include <Arduino.h>
#include <Wire.h>

#include "motor-speed-controller.h"

#include "pin-config.h"

#define DEBUG_MESSAGES

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

volatile byte currentCommand[COMMAND_LENGTH];
volatile int commandCounter = 0;

unsigned long now;
unsigned long frame_time;
unsigned long episode_time;
unsigned long debug_time;

MotorSpeedController motorA(AIN1, AIN2, PWMA, AENC1, AENC2);
MotorSpeedController motorB(BIN1, BIN2, PWMB, BENC1, BENC2);

void on_frame()
{
  motorA.loop();
  motorB.loop();
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

#ifdef DEBUG_MESSAGES
void on_debug()
{
  return;
  float rpm_a = (RPM_K * float(motorA.getCurrentSpeed())) / float(FRAME_INTERVAL);
  float rpm_b = (RPM_K * float(motorB.getCurrentSpeed())) / float(FRAME_INTERVAL);

  Serial.print("A=");
  Serial.print(motorA.getCurrentSpeed());
  Serial.print(",\t");
  Serial.print(rpm_a);
  Serial.print("rpm,\tpwm ");
  Serial.print(motorA.getCurrentPWM());
  Serial.print("\ti=");
  Serial.print(motorA.getCurrentPosition());
  Serial.print("\tB=");
  Serial.print(motorB.getCurrentSpeed());
  Serial.print("\t");
  Serial.print(rpm_b);
  Serial.print("rpm,\tpwm ");
  Serial.print(motorB.getCurrentPWM());
  Serial.print("\ti=");
  Serial.print(motorB.getCurrentPosition());
  Serial.println();
}

void log(String message)
{
  Serial.print(message);
}

void log(int value)
{
  Serial.print(value);
}

void logln()
{
  Serial.println();
}

void logcommandinput(volatile byte command[COMMAND_LENGTH], int length)
{
  Serial.print("Command=");
  for (int i = 0; i < length; i++)
  {
    Serial.print("0x");
    Serial.print(command[i], HEX);
    Serial.print("\t");
  }
  Serial.println();
}
#endif

int decodeByteCouple(byte char1, byte char2)
{
  return (char1 << 8) + char2;
}

void encodeByteCouple(int input, byte *out1, byte *out2)
{
  *out1 = input >> 8;
  *out2 = input & 0xFF;
}

void commandSetSpeed(volatile byte command[COMMAND_LENGTH])
{
  /*  M    255   255   255   255  */
  /*  0x4D 0x00  0x00  0x00  0x00 */
  int motorASpeed = decodeByteCouple(command[2], command[3]);
  int motorBSpeed = decodeByteCouple(command[4], command[5]);

#ifdef DEBUG_MESSAGES
  log("SetSpeed A=");
  log(motorASpeed);
  log("\tB=");
  log(motorBSpeed);
  logln();
#endif

  reset_episode();

  motorA.setPIDSpeed(motorASpeed);
  motorB.setPIDSpeed(motorBSpeed);
}

void commandSetPWM(volatile byte command[COMMAND_LENGTH])
{
  /*  P    255   255   255   255  */
  /*  0x4D 0x00  0x00  0x00  0x00 */
  int motorASpeed = decodeByteCouple(command[2], command[3]);
  int motorBSpeed = decodeByteCouple(command[4], command[5]);

#ifdef DEBUG_MESSAGES
  log("SetPWM A=");
  log(motorASpeed);
  log("\tB=");
  log(motorBSpeed);
  logln();
#endif

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

#ifdef DEBUG_MESSAGES
  log("Stopping");
  logln();
#endif

  motorA.stop();
  motorB.stop();
}

void interpretCommand(volatile byte command[COMMAND_LENGTH], int length)
{
#ifdef DEBUG_MESSAGES
  logcommandinput(command, length);
#endif

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

  default:
#ifdef DEBUG_MESSAGES
    log("Invalid Command");
    logln();
#endif
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
  /* MotorAPos MotorASpeed FrameInterval MotorBPos MotorBSpeed FrameInterval*/
  byte writeBuffer1 = 0xFF;
  byte writeBuffer2 = 0xFF;

  // encodeByteCouple(FRAME_INTERVAL, &writeBuffer1, &writeBuffer2);
  Wire.write(writeBuffer1);
  Wire.write(writeBuffer2);

  // encodeByteCouple(motorA.getCurrentSpeed(), writeBuffer1, writeBuffer2);
  // Wire.write(writeBuffer1);
  // Wire.write(writeBuffer2);

  // encodeByteCouple(FRAME_INTERVAL, writeBuffer1, writeBuffer2);
  // Wire.write(writeBuffer1);
  // Wire.write(writeBuffer2);

  // encodeByteCouple(motorB.getCurrentPosition(), writeBuffer1, writeBuffer2);
  // Wire.write(writeBuffer1);
  // Wire.write(writeBuffer2);

  // encodeByteCouple(motorB.getCurrentSpeed(), writeBuffer1, writeBuffer2);
  // Wire.write(writeBuffer1);
  // Wire.write(writeBuffer2);

  // encodeByteCouple(FRAME_INTERVAL, writeBuffer1, writeBuffer2);
  // Wire.write(writeBuffer1);
  // Wire.write(writeBuffer2);
}

void setup()
{
#ifdef DEBUG_MESSAGES
  Serial.begin(9600);
#endif

  Wire.begin(DEVICE_ID);

  Wire.onReceive(wireRecieveEvent);
  Wire.onRequest(wireRequestEvent);

  // Enable the motor driver
  pinMode(STBY, OUTPUT);
  digitalWrite(STBY, HIGH);

  // Initialize motors
  motorA.setup();
  motorB.setup();

  // motorB.setReverse();

  // Stop the motors
  motorA.stop();
  motorB.stop();
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

#ifdef DEBUG_MESSAGES
  if (now - debug_time > DEBUG_INTERVAL)
  {
    on_debug();
    debug_time = now;
  }
#endif
}

// `6000 int is one rev