#include "RobotDriver.h"

RobotDriver::RobotDriver()
{
  deviceID = 1;
  commandLength = 10;
  command = "";
  response = "";

  PWMB = 11;
  BIN2 = 10;
  BIN1 = 9;
  
  STBY = 8;
  
  AIN1 = 7;
  AIN2 = 6;
  PWMA = 5;
  

  motorLinearSpeed = 75;
  motorTurnSpeed = 100;

}

bool RobotDriver::readLine()
{
  while (Serial.available()) {
    char lastByte = Serial.read();
    if (lastByte == '\n') {
      return true;
    }
    command += String(lastByte);
  }
  return false;
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
  
  Serial.begin(9600);
}

bool RobotDriver::processCommand()
{
  String msg;
  
  response = "R";
  
  switch (command[0]) {
    case 'f':
      setMotor(0, motorLinearSpeed, 1);
      setMotor(1, motorLinearSpeed, 1);
      break;
      
    case 'b':
      setMotor(0, motorLinearSpeed, 0);
      setMotor(1, motorLinearSpeed, 0);
      break;
      
    case 'r':
      setMotor(0, motorTurnSpeed, 1);
      setMotor(1, motorTurnSpeed, 0);
      break;
      
    case 'l':
      setMotor(0, motorTurnSpeed, 0);
      setMotor(1, motorTurnSpeed, 1);
      break;
      
    case 's':
      setMotor(0, 0, 0);
      setMotor(1, 0, 0);
      break;

    case 'm':
      msg = command.substring(1);
      Serial.print(msg);
      
    case 'd':
      /* Set Differential Speed
       *  0 - d
       *  1 - right wheel direction 1 forward, 0 back
       *  2 - right wheel speed 0-255
       *  3 - left wheel direction 1 forward, 0 back
       *  4 - left wheel speed 0-255
       */
      if (command.length() != 5) {
        return false;
      }
      int rd,rs,ld,ls;
      
      rd = (int(char(command[1])) == 0) ? 0 : 1;
      rs = int(char(command[2]));
      ld = (int(char(command[3])) == 0) ? 0 : 1;
      ls = int(char(command[4]));

      setMotor(0, ls, ld);
      setMotor(1, rs, rd);

      response += " ";
      response += String(rd);
      response += " ";
      response += String(rs);
      response += " ";
      response += String(ld);
      response += " ";
      response += String(ls);
      break;

    case 'c':
      /* read collision detection sensor */

      int v;
      v = analogRead(0);

      response += " ";
      response += String(v);
      
    default:
      return false;
  }

  return true;
}


bool RobotDriver::sendResponse()
{
  response += " ";
  response += command;
  response += " ";
  response += String(millis());
  
  Serial.println(response);
  return 0;
}


void RobotDriver::setMotor(int motor, int speed, int direction) {
  digitalWrite(STBY, HIGH);

  boolean inPin1 = LOW;
  boolean inPin2 = HIGH;

  if (direction == 1) {
    inPin1 = HIGH;
    inPin2 = LOW;
  }

  if (motor == 1) {
    digitalWrite(BIN1, inPin1);
    digitalWrite(BIN2, inPin2);
    analogWrite(PWMB, speed);
  } else {
    digitalWrite(AIN1, inPin1);
    digitalWrite(AIN2, inPin2);
    analogWrite(PWMA, speed);
  }
}


void RobotDriver::loop()
{
  if (Serial.available() > 0) {
    if (readLine()) {
      bool result = processCommand();
      if (result == false) {
        response += " ER";
      } else {
        response += " OK";
      }
      sendResponse();
      command = "";
    }
  }

  //Autonomous behaviour here, eg: collision detection etc.

  //Collision detenction
  /*
  int v;
  v = analogRead(0);

  if (v < 800) {
    setMotor(0, 0, 0);
    setMotor(1, 0, 0);
  }
  */
}

