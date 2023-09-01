#include <Arduino.h>

#include "motor-speed-controller.h"

#include "pin-config.h"

#define FRAME_INTERVAL 30
#define EPISODE_INTERVAL 5000
#define DEBUG_INTERVAL 30

MotorSpeedController motorA(AIN1, AIN2, PWMA, AENC1, AENC2);
MotorSpeedController motorB(BIN1, BIN2, PWMB, BENC1, BENC2);

unsigned long now;
unsigned long frame_time;
unsigned long episode_time;
unsigned long debug_time;

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

  // motorB.setPWMSpeed(100);
  // motorA.setPWMSpeed(100);
  motorA.setPIDSpeed(-100);
  motorB.setPIDSpeed(100);
}

void on_frame()
{
  motorA.loop();
  motorB.loop();
}

void on_epidose()
{
  motorA.stop();
  motorB.stop();
}

void on_debug()
{
  Serial.print("A=");
  Serial.print(motorA.getCurrentSpeed());
  Serial.print("\ti=");
  Serial.print(motorA.getCurrentPosition());
  Serial.print("\tB=");
  Serial.print(motorB.getCurrentSpeed());
  Serial.print("\ti=");
  Serial.print(motorB.getCurrentPosition());
  Serial.println();
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
    on_epidose();
    episode_time = now;
  }

  if (now - debug_time > DEBUG_INTERVAL)
  {
    on_debug();
    debug_time = now;
  }
}

// `1500 int is one rev