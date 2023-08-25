
#ifndef MOTOR_SPEED_CONTROLLER_H
#define MOTOR_SPEED_CONTROLLER_H

#include <Arduino.h>

#define FORWARD 1
#define BACKWARD 0

#define MAX_PWM 255

class MotorSpeedController
{
public:
    MotorSpeedController(uint8_t inPin1, uint8_t inPin2, uint8_t pwmPin);
    void setup();
    void loop();

    void incrementInterrupt();

    void setPIDSpeed(int speed);

    void setPWMSpeed(int pwm);

    void stop();

    int getCurrentSpeed();

    void updatePIDParameters(int Kp, int Kd, int Ki, int Ko);

    // private:
    uint8_t inPin1_;
    uint8_t inPin2_;
    uint8_t pwmPin_;

    int Kp_;
    int Kd_;
    int Ki_;
    int Ko_;

    bool pidControl_;
    bool direction_;

    unsigned long interruptCounter_;

    unsigned long prevCount_;

    int prevInput_;
    int ITerm_;
    int pidOutput_;

    int currentSpeed_;
    int targetSpeed_;

    void resetPID();
    void doPID();

    void setPWM(uint8_t pwm);
    void setDirection(bool direction);
};

#endif