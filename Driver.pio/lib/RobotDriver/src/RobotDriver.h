#include <Arduino.h>
#include <Wire.h>

#define MOTOR_A 0
#define MOTOR_B 1

#define FORWARD 1
#define BACKWARD 0

#define STATE_STOPPED 0
#define STATE_FOWARD 1
#define STATE_FOWARD_STEPS 2
#define STATE_BACKWARD 3
#define STATE_BACKWARD_STEPS 4
#define STATE_TURN_RIGHT 5
#define STATE_TURN_RIGHT_STEPS 6
#define STATE_TURN_LEFT 7
#define STATE_TURN_LEFT_STEPS 8

#define CMD_STOP 'S'

#define ERROR_NONE 0
#define ERROR_COLLISION_FRONT 1
#define ERROR_COLLISION_BACK 2
#define ERROR_EDGE_FRONT 3
#define ERROR_EDGE_BACK 4

class RobotDriver
{
  public:
    RobotDriver();
    void setup();
    void loop();
    void moveForward(int steps, int speed);
    void moveBackward(int steps, int speed);
    
  protected:
    String command;
    String previousCommand;
    String response;
    int deviceID;
    int commandLength;

    int state;
    int error;

    int motorLinearSpeed;
    int motorTurnSpeed;
    
    int STBY;
    int PWMA;
    int AIN1;
    int AIN2;
    int PWMB;
    int BIN1;
    int BIN2;

    int AINT; //Interrupt pin for wheel A
    int BINT; //Interrupt pin for wheel B

    volatile int counterA; //Counter for wheel A
    volatile int counterB; //Counter for wheel B

    int targetStepsA;
    int targetStepsB;

    void setMotor(int motor, int speed, int direction);
    void stopMotor(int motor);

    void collisionDetect();

  private:
    static RobotDriver* driver;

    static void ISR_updateA();
    static void ISR_updateB();

    static void I2C_recieveEvent(int howMany);
    static void I2C_requestEvent();

    void I2C_SendStatus();
    void I2C_ProcessCommand(String command);
};