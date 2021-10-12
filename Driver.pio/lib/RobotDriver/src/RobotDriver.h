#include <Arduino.h>

class RobotDriver
{
  public:
    RobotDriver();
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
};