#include <Wire.h>
#include <LiquidCrystal_I2C.h>


class RobotPlatform
{
  public:
    RobotPlatform();
    void setup();
    void loop();
    bool processCommand();
    bool sendResponse();
  protected:
    String command;
    String previousCommand;
    String response;
    int deviceID;
    int commandLength;
    bool readLine(); //reads till \n or end of buffer.

    void setMotor(int motor, int speed, int direction);

    int motorLinearSpeed;
    int motorTurnSpeed;
    
    int STBY;
    int PWMA;
    int AIN1;
    int AIN2;
    int PWMB;
    int BIN1;
    int BIN2;

    LiquidCrystal_I2C *lcd;
};


RobotPlatform::RobotPlatform()
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

  lcd = new LiquidCrystal_I2C(0x27, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);
}

bool RobotPlatform::readLine()
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

void RobotPlatform::setup()
{
  pinMode(STBY, OUTPUT);

  pinMode(PWMA, OUTPUT);
  pinMode(AIN1, OUTPUT);
  pinMode(AIN2, OUTPUT);

  pinMode(PWMB, OUTPUT);
  pinMode(BIN1, OUTPUT);
  pinMode(BIN2, OUTPUT);
  
  Serial.begin(9600);

  lcd->begin(16,2);
}

bool RobotPlatform::processCommand()
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
      lcd->setCursor(0,0);
      lcd->print(msg);
      
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


bool RobotPlatform::sendResponse()
{
  response += " ";
  response += command;
  response += " ";
  response += String(millis());
  
  Serial.println(response);
  return 0;
}


void RobotPlatform::setMotor(int motor, int speed, int direction) {
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


void RobotPlatform::loop()
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



RobotPlatform rover;

void setup()
{
  rover.setup();
}

void loop()
{
  rover.loop();
  delay(100);
}
/*


int STBY = 4;

int PWMA = 6;
int AIN1 = 8;
int AIN2 = 7;

int PWMB = 11;
int BIN1 = 9;
int BIN2 = 10;

int timer = 0;
char serialIn = 's';

int rspeed = 50;

char left_wheel_speed = 0;
char left_wheel_dir   = 0; //or 1
char right_wheel_speed = 0;
char right_wheel_dir   = 0; //or 1


//left blue white, green white

//right white white, green blue

void move(int motor, int speed, int direction) {
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

void stop(){
//enable standby  
  digitalWrite(STBY, LOW); 
}

void setup() {
  // put your setup code here, to run once:
  pinMode(STBY, OUTPUT);

  pinMode(PWMA, OUTPUT);
  pinMode(AIN1, OUTPUT);
  pinMode(AIN2, OUTPUT);

  pinMode(PWMB, OUTPUT);
  pinMode(BIN1, OUTPUT);
  pinMode(BIN2, OUTPUT);

  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  //move(0, 100, 0);
  //move(1, 100, 0);

  //delay(1000);

  //move(0, 100, 1);
  //move(1, 100, 1);

  //delay(1000);

  
  if (Serial.available() >= 4) {
    left_wheel_speed = int(Serial.read());
    left_wheel_dir   = int(Serial.read());
    right_wheel_speed = int(Serial.read());
    right_wheel_dir = int(Serial.read());

    Serial.print("I recieved: left speed=");
    Serial.print(left_wheel_speed);
    Serial.print(" left wheel dir=");
    Serial.print(left_wheel_dir);
    Serial.print(" right wheel speed=");
    Serial.print(right_wheel_speed);
    Serial.print(" right wheel dir=");
    Serial.print(right_wheel_dir);
    Serial.println("");

    timer = 0;
  }

  if (serialIn == 'b') {
    move(0, rspeed, 0);
    move(1, rspeed, 0);
  }
  if (serialIn == 'f') {
    move(0, rspeed, 1);
    move(1, rspeed, 1);
  }
  if (serialIn == 'r') {
    move(0, rspeed, 1);
    move(1, rspeed, 0);
  }
  if (serialIn == 'l') {
    move(0, rspeed, 0);
    move(1, rspeed, 1);
  }

  if (serialIn == 's') {
    move(0, 0, 0);
    move(1, 0, 0);
  }

  if (timer > 50) {
    serialIn = 's';
    //Serial.println("Stopping");
    timer = 0;
  }

  timer += 1;
  //Serial.print(timer);
  //Serial.print(" ");
  //Serial.println(serialIn);
  delay(100);
}
*/
