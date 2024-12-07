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

volatile byte currentCommand[COMMAND_LENGTH];
volatile int commandCounter = 0;

volatile int currentRegister = 0;

unsigned long now;
unsigned long frame_time;
unsigned long episode_time;
unsigned long debug_time;

MotorSpeedController motorA(AIN1, AIN2, PWMA, AENC1, AENC2);
MotorSpeedController motorB(BIN1, BIN2, PWMB, BENC1, BENC2);

volatile byte dataRegistery[8];

int decodeByteInt(byte char1, byte char2)
{
  return (char1 << 8) + char2;
}

void encodeIntByte(int input, byte *out1, byte *out2)
{
  *out1 = input >> 8;
  *out2 = input & 0xFF;
}

long decodeByteLong(byte char1, byte char2, byte char3, byte char4)
{
  return ((long)char1 << 24) |
         ((long)char2 << 16) |
         ((long)char3 << 8) |
         (long)char4;
}

void encodeLongByte(long input, byte *out1, byte *out2, byte *out3, byte *out4)
{
  *out1 = (input >> 24) & 0xFF; // Most Significant Byte
  *out2 = (input >> 16) & 0xFF;
  *out3 = (input >> 8) & 0xFF;
  *out4 = input & 0xFF; // Least Significant Byte
}

long decodeLong(byte (&arr)[4])
{
  return ((long)arr[0] << 24) |
         ((long)arr[1] << 16) |
         ((long)arr[2] << 8) |
         (long)arr[3];
}

byte *encodeLong(long input)
{
  static byte result[4];
  result[0] = (input >> 24) & 0xFF; // Most Significant Byte
  result[1] = (input >> 16) & 0xFF;
  result[2] = (input >> 8) & 0xFF;
  result[3] = input & 0xFF; // Least Significant Byte
  return result;
}

void on_frame()
{
  motorA.loop();
  motorB.loop();

  // Update the dataRegistery.
  // Registers 0 to 3: MotorA position long encoded as 4 bytes
  // Registers 4 to 7: MotorB position long encoded as 4 bytes

  byte *motorPosition;
  motorPosition = encodeLong(motorA.getCurrentPosition());

  dataRegistery[0] = motorPosition[0];
  dataRegistery[1] = motorPosition[1];
  dataRegistery[2] = motorPosition[2];
  dataRegistery[3] = motorPosition[3];

  motorPosition = encodeLong(motorB.getCurrentPosition());

  dataRegistery[4] = motorPosition[0];
  dataRegistery[5] = motorPosition[1];
  dataRegistery[6] = motorPosition[2];
  dataRegistery[7] = motorPosition[3];
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
  // return;
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

void commandSetSpeed(volatile byte command[COMMAND_LENGTH])
{
  /*  M    255   255   255   255  */
  /*  0x4D 0x00  0x00  0x00  0x00 */
  int motorASpeed = decodeByteInt(command[2], command[3]);
  int motorBSpeed = decodeByteInt(command[4], command[5]);

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
  int motorASpeed = decodeByteInt(command[2], command[3]);
  int motorBSpeed = decodeByteInt(command[4], command[5]);

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

void commandSetRegister(volatile byte command[COMMAND_LENGTH])
{
  /*  255  255   */
  /*  0xFF 0x00  */
  currentRegister = command[2];
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

  case COMMAND_SET_REGISTER:
    commandSetRegister(command);
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
  Serial.println(currentRegister);
  Wire.write(dataRegistery[currentRegister]);
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

  reset_episode();

#ifdef DEBUG_MESSAGES
  log("Motor Speed Controller Started\n");
#endif
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

  // #ifdef DEBUG_MESSAGES
  //   if (now - debug_time > DEBUG_INTERVAL)
  //   {
  //     on_debug();
  //     debug_time = now;
  //   }
  // #endif
}

// `6000 int is one rev