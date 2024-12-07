from typing import Tuple, List
import time
from robot_state import MotorControllerState

MOTOR_ADDRESS = 0x09

MOTOR_COMMAND_SET_SPEED = 0x4D
MOTOR_COMMAND_SET_PWM = 0x50
MOTOR_COMMAND_STOP = 0x53
MOTOR_COMMAND_SET_REGISTER = 0xFF


class MotorController():
    def __init__(self, bus) -> None:
        self._bus = bus

    def encode_int_char_couple(self, value: int) -> Tuple[int, int]:
        char1 = (value >> 8) & 0xFF
        char2 = value & 0xFF
        return char1, char2

    def decode_long(self, bytes: Tuple) -> int:
        value = (
            (bytes[0] << 24) |
            (bytes[1] << 16) |
            (bytes[2] << 8) |
            bytes[3]
        )

        if value & (1 << 31):  # Check if the sign bit is set
            value -= 1 << 32
        return value

    def set_motor_speed(self, motora: int, motorb: int) -> None:
        speed_a = self.encode_int_char_couple(motora)
        speed_b = self.encode_int_char_couple(motorb)

        self._bus.i2c.write_i2c_block_data(
            MOTOR_ADDRESS, 0,
            [
                MOTOR_COMMAND_SET_SPEED,
                speed_a[0],
                speed_a[1],
                speed_b[0],
                speed_b[1]
            ]
        )

    def set_motor_pwm(self, motora: int, motorb: int) -> None:
        speed_a = self.encode_int_char_couple(motora)
        speed_b = self.encode_int_char_couple(motorb)

        self._bus.i2c.write_i2c_block_data(
            MOTOR_ADDRESS, 0,
            [
                MOTOR_COMMAND_SET_PWM,
                speed_a[0],
                speed_a[1],
                speed_b[0],
                speed_b[1]
            ]
        )

    def read_register(self, register_offset: int) -> None:
        self._bus.i2c.write_i2c_block_data(
            MOTOR_ADDRESS, 0,
            [
                MOTOR_COMMAND_SET_REGISTER,
                register_offset
            ]
        )
        return self._bus.i2c.read_byte(MOTOR_ADDRESS)

    def get_state(self):

        return MotorControllerState(
            motora_counter=self.decode_long((
                self.read_register(0),
                self.read_register(1),
                self.read_register(2),
                self.read_register(3))),
            motorb_counter=self.decode_long((
                self.read_register(4),
                self.read_register(5),
                self.read_register(6),
                self.read_register(7)))
        )
