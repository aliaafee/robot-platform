import smbus
import time
import math

# from PIL import Image, ImageDraw
# import digitalio
# import board
# from adafruit_rgb_display.rgb import color565

# import display_controller
import l3gd20
import lsm303
import motor_controller
from robot_state import Command, Telemetry, RobotState


class RobotController:
    def __init__(self, frequency, state) -> None:
        self.state = state

        self.i2c = smbus.SMBus(1)

        self.motor = motor_controller.MotorController(self.i2c)
        self.gyro = l3gd20.L3GD20(self.i2c)
        self.accel_mag = lsm303.LSM303(self.i2c)

        # self.spi = board.SPI()

        # self.screen = display_controller.DisplayController(
        #     self.spi,
        #     rotation=90,
        #     cs_pin=digitalio.DigitalInOut(board.CE0),
        #     dc_pin=digitalio.DigitalInOut(board.D24),
        #     reset_pin=digitalio.DigitalInOut(board.D25)
        # )

        # self.screen.clear()

        self.frequency = frequency
        self.frame_duration = 1.0 / self.frequency

        self.wheel_base = 0.11

        self.command_map = {
            'set_motor_speed': self.command_set_motor_speed,
            'stop_motors': self.command_stop_motors
        }

    def loop(self):
        start_time = time.time()

        # self.telemetry = {
        #     'time': time.time(),
        #     'gyro': self.gyro.read(),
        #     'accel': self.accel_mag.read_accel(),
        #     'mag': self.accel_mag.read_mag()

        # }

        self.current_telemetry = Telemetry(
            time=time.time(),
            gyro=self.gyro.read(),
            accel=self.accel_mag.read_accel(),
            mag=self.accel_mag.read_mag()
        )

        self.state.push_telemetry(self.current_telemetry)

        while True:
            command = self.state.get_command()

            if command is None:
                break

            self.on_command(command)

        self.on_frame()

        try:
            time.sleep(self.frame_duration - (time.time() - start_time))
        except ValueError:
            pass

    def set_steering(self, speed: float, angle: float) -> None:
        if angle == 0:
            self.motor.set_motor_speed(speed, -speed)
            return

        angle = angle * (180 / math.pi)
        radius = self.wheel_base / math.tan(angle)

        left_speed = speed * (2 * radius - self.wheel_base) / (2 * radius)
        right_speed = speed * (2 * radius + self.wheel_base) / (2 * radius)

        self.motor.set_motor_speed(int(left_speed), -int(right_speed))

    def stop(self):
        self.motor.set_motor_pwm(0, 0)

    def on_command(self, command: Command):
        if command.name not in self.command_map:
            print(f"Unknow Command: {command}")
            return

        self.command_map[command.name](command.arguments)

    def command_set_motor_speed(self, arguments):
        self.motor.set_motor_speed(*arguments)

    def command_stop_motors(self, arguments):
        self.motor.set_motor_pwm(0, 0)

    def on_frame(self):
        pass
