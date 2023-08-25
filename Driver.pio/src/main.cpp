#include <Arduino.h>

#include "motor-speed-controller.h"

#include "pin-config.h"

MotorSpeedController motorA(AIN1, AIN2, PWMA);
MotorSpeedController motorB(BIN1, BIN2, PWMB);

volatile unsigned long a_count=0;

void ISR_updateA()
{
  motorA.incrementInterrupt();
}

void ISR_updateB()
{
  motorB.incrementInterrupt();
}

void setup()
{
  Serial.begin(9600);

  // Enable the motor driver
  pinMode(STBY, OUTPUT);
  digitalWrite(STBY, HIGH);

  // Initialize motors
  motorA.setup();
  motorB.setup();

  // Stop the motors
  motorA.stop();
  motorB.stop();

  // Attach motor interrupt pin
  attachInterrupt(digitalPinToInterrupt(AINT), ISR_updateA, RISING);
  attachInterrupt(digitalPinToInterrupt(BINT), ISR_updateB, RISING);

  // motorB.setPWMSpeed(100);
  //motorA.setPWMSpeed(100);
  motorA.setPIDSpeed(-20);
  motorB.setPIDSpeed(-20);
}

void loop()
{
  motorA.loop();
  motorB.loop();
  
  Serial.print("A=");
  Serial.print(motorA.getCurrentSpeed());
  Serial.print("\ti=");
  Serial.print(motorA.interruptCounter_);
  Serial.print("\tB=");
  Serial.print(motorB.getCurrentSpeed());
  Serial.print("\ti=");
  Serial.print(motorB.interruptCounter_);
  Serial.println();

  delay(30);
}

// `1500 int is one rev