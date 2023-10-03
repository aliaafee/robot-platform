
#ifndef MOTOR_SPEED_CONTROLLER_H
#define MOTOR_SPEED_CONTROLLER_H

#include <Arduino.h>

#include <Encoder.h>

#define FORWARD 1
#define BACKWARD 0

#define MIN_PWM -255
#define MAX_PWM 255

class MotorSpeedController
{
public:
    MotorSpeedController(uint8_t inPin1, uint8_t inPin2, uint8_t pwmPin, uint8_t encoderPin1_, uint8_t encoderPin2_);
    void setup();
    void loop();

    void setPIDSpeed(int speed);

    void stopPIDControl();

    void setPWMSpeed(int pwm);

    void stop();

    int getCurrentSpeed();

    int getCurrentPWM();

    long getCurrentPosition();

    void updatePIDParameters(int Kp, int Kd, int Ki, int Ko);

//private:
    uint8_t inPin1_;
    uint8_t inPin2_;
    uint8_t pwmPin_;

    uint8_t encoderPin1_;
    uint8_t encoderPin2_;

    Encoder *encoder_;

    int Kp_;
    int Kd_;
    int Ki_;
    int Ko_;

    bool pidControl_;

    long prevCount_;

    int prevInput_;
    int ITerm_;
    int pidOutput_;

    int currentSpeed_;
    int targetSpeed_;

    int currentPWM_;

    void resetPID();
    void doPID();

    void setPWM(uint8_t pwm);
    void setDirection(bool direction);
};

#endif