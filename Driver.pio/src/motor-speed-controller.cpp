#include "motor-speed-controller.h"

MotorSpeedController::MotorSpeedController(uint8_t inPin1, uint8_t inPin2, uint8_t pwmPin, uint8_t encoderPin1, uint8_t encoderPin2)
{
    inPin1_ = inPin1;
    inPin2_ = inPin2;
    pwmPin_ = pwmPin;

    encoderPin1_ = encoderPin1;
    encoderPin2_ = encoderPin2;

    encoder_ = new Encoder(encoderPin1_, encoderPin2_);

    Kp_ = 20;
    Kd_ = 12;
    Ki_ = 0;
    Ko_ = 50;

    pidControl_ = false;
    resetPID();
}

void MotorSpeedController::setup()
{
    pinMode(inPin1_, OUTPUT);
    pinMode(inPin2_, OUTPUT);
    pinMode(pwmPin_, OUTPUT);

    prevCount_ = 0;
    currentSpeed_ = 0;
}

void MotorSpeedController::loop()
{
    currentSpeed_ = encoder_->read() - prevCount_;

    prevCount_ = encoder_->read();

    if (pidControl_)
    {
        doPID();
    }
}

void MotorSpeedController::setPIDSpeed(int speed)
{
    pidControl_ = true;
    resetPID();
    targetSpeed_ = speed;
}

void MotorSpeedController::setPWMSpeed(int pwm)
{
    if (pwm < 0)
    {
        setDirection(BACKWARD);
    }
    else
    {
        setDirection(FORWARD);
    }
    setPWM(abs(pwm));
}

void MotorSpeedController::stop()
{
    pidControl_ = false;
    digitalWrite(inPin1_, HIGH);
    digitalWrite(inPin2_, HIGH);
    setPWM(0);
}

int MotorSpeedController::getCurrentSpeed()
{
    return currentSpeed_;
}

long MotorSpeedController::getCurrentPosition()
{
    return encoder_->read();
}

void MotorSpeedController::updatePIDParameters(int Kp, int Kd, int Ki, int Ko)
{
    Kp_ = Kp;
    Kd_ = Kd;
    Ki_ = Ki;
    Ko_ = Ko;
}

void MotorSpeedController::resetPID()
{
    prevInput_ = 0;
    ITerm_ = 0;
    pidOutput_ = 0;
}

void MotorSpeedController::doPID()
{
    // From https://github.com/joshnewans/ros_arduino_bridge/blob/main/ROSArduinoBridge/diff_controller.h
    long Perror;
    long output;
    int input = currentSpeed_;

    Perror = targetSpeed_ - currentSpeed_;
    output = (Kp_ * Perror - Kd_ * (input - prevInput_) + ITerm_) / Ko_;

    output += pidOutput_;

    if (output >= MAX_PWM)
    {
        output = MAX_PWM;
    }
    else if (output <= MIN_PWM)
    {
        output = 0;
    }
    else
    {
        ITerm_ += Ki_ * Perror;
    }

    pidOutput_ = output;
    prevInput_ = input;

    setPWMSpeed(pidOutput_);
}

void MotorSpeedController::setPWM(uint8_t pwm)
{
    analogWrite(pwmPin_, pwm);
}

void MotorSpeedController::setDirection(bool direction)
{
    if (direction)
    {

        digitalWrite(inPin1_, LOW);
        digitalWrite(inPin2_, HIGH);
        return;
    }

    digitalWrite(inPin1_, HIGH);
    digitalWrite(inPin2_, LOW);
}
