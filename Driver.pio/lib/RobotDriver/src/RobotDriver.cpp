#include "RobotDriver.h"

RobotDriver::RobotDriver()
{
  deviceID = 4;

  PWMB = 11;
  BIN2 = 10;
  BIN1 = 9;
  
  STBY = 8;
  
  AIN1 = 7;
  AIN2 = 6;
  PWMA = 5;

  BINT = 3;
  AINT = 2;

  counterA = 0;
  counterB = 0;

  motorLinearSpeed = 75;
  motorTurnSpeed = 100;

}

RobotDriver* RobotDriver::driver = 0;

void RobotDriver::ISR_updateA()
{
  driver->counterA++;
}

void RobotDriver::ISR_updateB()
{
  driver->counterB++;
}

void RobotDriver::I2C_recieveEvent(int howMany)
{
  String command = "";
  while(Wire.available())
  {
    char c = Wire.read();
    command += String(c);
  }
  driver->I2C_ProcessCommand(command);
}

void RobotDriver::I2C_requestEvent()
{
  driver->I2C_SendStatus();
}

void RobotDriver::I2C_SendStatus()
{
  Wire.write(char(state));
}

void RobotDriver::I2C_ProcessCommand(String command)
{
  //Do something with the command
  switch (command[0])
  {
  case CMD_STOP:
    stopMotor(MOTOR_A);
    stopMotor(MOTOR_B);
    break;
  
  default:
    break;
  }
}

void RobotDriver::setup()
{
  pinMode(STBY, OUTPUT);

  pinMode(PWMA, OUTPUT);
  pinMode(AIN1, OUTPUT);
  pinMode(AIN2, OUTPUT);

  pinMode(PWMB, OUTPUT);
  pinMode(BIN1, OUTPUT);
  pinMode(BIN2, OUTPUT);

  counterA = 0;
  counterB = 0;

  driver = this;

  attachInterrupt(digitalPinToInterrupt(AINT), RobotDriver::ISR_updateA, RISING);
  attachInterrupt(digitalPinToInterrupt(BINT), RobotDriver::ISR_updateB, RISING);
  
  Wire.begin(deviceID);

  state = STATE_STOPPED;
  error = ERROR_NONE;
}

void RobotDriver::moveForward(int steps, int speed)
{
  state = STATE_FOWARD_STEPS;

  counterA = 0;
  counterB = 0;

  targetStepsA = steps;
  targetStepsB = steps;
}


void RobotDriver::moveBackward(int steps, int speed)
{
  state = STATE_BACKWARD_STEPS;

  counterA = 0;
  counterB = 0;

  targetStepsA = steps;
  targetStepsB = steps;
}


void RobotDriver::setMotor(int motor, int speed, int direction) {
  digitalWrite(STBY, HIGH);

  boolean inPin1 = LOW;
  boolean inPin2 = HIGH;

  if (direction == FORWARD) {
    inPin1 = HIGH;
    inPin2 = LOW;
  }

  if (motor == MOTOR_B) {
    digitalWrite(BIN1, inPin1);
    digitalWrite(BIN2, inPin2);
    analogWrite(PWMB, speed);
  } else {
    digitalWrite(AIN1, inPin1);
    digitalWrite(AIN2, inPin2);
    analogWrite(PWMA, speed);
  }
}

void RobotDriver::stopMotor(int motor)
{
  if (motor == MOTOR_B) {
    digitalWrite(BIN1, LOW);
    digitalWrite(BIN2, LOW);
    analogWrite(PWMB, 0);
  } else {
    digitalWrite(AIN1, LOW);
    digitalWrite(AIN2, LOW);
    analogWrite(PWMA, 0);
  }
}


void RobotDriver::readSensors()
{
  //Read all sensors
}


void RobotDriver::collisionDetect()
{
  //Collision detection, based on current sensor readings
  //If collision, halt and set error variable to appropriate error state
}


void RobotDriver::updateState()
{
  switch (state)
  {
  case STATE_FOWARD:
    setMotor(MOTOR_A, motorLinearSpeed, FORWARD);
    setMotor(MOTOR_B, motorLinearSpeed, FORWARD);
    break;
  case STATE_FOWARD_STEPS:
    if (targetStepsA < counterA && targetStepsB < counterB) {
      setMotor(MOTOR_A, motorLinearSpeed, FORWARD);
      setMotor(MOTOR_B, motorLinearSpeed, FORWARD);
    } else {
      targetStepsA = 0;
      targetStepsB = 0;
      state = STATE_STOPPED;
      stopMotor(MOTOR_A);
      stopMotor(MOTOR_B);
    }
    break;
  case STATE_BACKWARD:
    setMotor(MOTOR_A, motorLinearSpeed, BACKWARD);
    setMotor(MOTOR_B, motorLinearSpeed, BACKWARD);
    break;
  case STATE_BACKWARD_STEPS:
    if (targetStepsA < counterA && targetStepsB < counterB) {
      setMotor(MOTOR_A, motorLinearSpeed, BACKWARD);
      setMotor(MOTOR_B, motorLinearSpeed, BACKWARD);
    } else {
      targetStepsA = 0;
      targetStepsB = 0;
      state = STATE_STOPPED;
      stopMotor(MOTOR_A);
      stopMotor(MOTOR_B);
    }
    break;
  case STATE_STOPPED:
  default:
    stopMotor(MOTOR_A);
    stopMotor(MOTOR_B);
    break;
  }
}


void RobotDriver::loop()
{
  readSensors();

  collisionDetect();

  updateState();
}

