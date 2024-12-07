from smbus2 import SMBus
import time
import math
import logging
# import ahrs
# from ahrs.common.orientation import acc2q, q2euler
# import numpy

# from PIL import Image, ImageDraw
# import digitalio
# import board
# from adafruit_rgb_display.rgb import color565

# import display_controller
# import l3gd20
# import lsm303
import motor_controller
from robot_state import Command, Telemetry, RobotState, MotorControllerState


class Bus:
    def __init__(self, i2c_busid):
        self.i2c_busid = i2c_busid
        self.i2c = None

    def open_i2c(self):
        self.i2c = SMBus(self.i2c_busid)

    def close_i2c(self):
        self.i2c.close()


class RobotController:
    def __init__(self, frequency, state) -> None:
        self.state = state

        self.bus = Bus(i2c_busid=1)

        self.motor = motor_controller.MotorController(self.bus)

        self.frequency = frequency
        self.frame_duration = 1.0 / self.frequency

        self.wheel_base = 0.11

        self.command_map = {
            'set_motor_speed': self.command_set_motor_speed,
            'set_steering': self.command_set_steering,
            'stop_motors': self.command_stop_motors
        }

    def loop(self):
        start_time = time.time()

        try:
            self.bus.open_i2c()

            self.current_telemetry = Telemetry(
                time=time.time(),
                message="ok",
                gyro=(1, 0, 0),
                accel=(0, 0, 0),
                mag=(1, 0, 0),
                orientation=(0, 0, 0, 0),
                orientation_angles=(0, 0, 0),
                motor_controller=self.motor.get_state()
            )

            self.state.push_telemetry(self.current_telemetry)

            self.on_command(self.state.get_command())

            self.on_frame()

            self.bus.close_i2c()
        except OSError as e:
            logging.error(f"Error in RobotController Loop: {e.strerror}")

            self.current_telemetry = Telemetry(
                time=time.time(),
                message=e.strerror,
                gyro=(1, 0, 0),
                accel=(0, 0, 0),
                mag=(1, 0, 0),
                orientation=(0, 0, 0, 0),
                orientation_angles=(0, 0, 0),
                motor_controller=MotorControllerState(0, 0)
            )

            self.state.push_telemetry(self.current_telemetry)

        try:
            time.sleep(self.frame_duration - (time.time() - start_time))
        except ValueError:
            pass

    def set_steering(self, speed: float, angle: float) -> None:
        if angle == 0:
            self.motor.set_motor_speed(int(speed), -int(speed))
            return

        a_speed = angle / 90.0 * speed
        b_speed = speed - a_speed

        self.motor.set_motor_speed(int(a_speed), -int(b_speed))

    def stop(self):
        self.motor.set_motor_pwm(0, 0)

    def on_command(self, command: Command):
        if command is None:
            return

        if command.name not in self.command_map:
            logging.error(f"Unknow Command: {command}")
            return

        self.command_map[command.name](command.arguments)

    def command_set_motor_speed(self, arguments):
        try:
            self.motor.set_motor_speed(*arguments)
        except Exception as e:
            logging.error(f"command_set_motor_speed error {str(e)}")

    def command_set_steering(self, arguments):
        try:
            self.set_steering(*arguments)
        except Exception as e:
            logging.error(f"command_set_steering error {str(e)}")

    def command_stop_motors(self, arguments):
        try:
            self.motor.set_motor_pwm(0, 0)
        except Exception as e:
            logging.error(f"command_stop_motors error {str(e)}")

    def on_frame(self):
        pass
