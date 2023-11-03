import smbus
from typing import Tuple

MOTOR_ADDRESS = 0x09

MOTOR_COMMAND_SET_SPEED = 0x4D
MOTOR_COMMAND_SET_PWM = 0x50
MOTOR_COMMAND_STOP = 0x53


class MotorController():
    def __init__(self, i2c) -> None:
        self._bus = i2c

    def encode_int_char_couple(self, value: int) -> Tuple[int, int]:
        char1 = (value >> 8) & 0xFF
        char2 = value & 0xFF
        return char1, char2
    
    def set_motor_speed(self, motora: int, motorb: int) -> None:
        speed_a = self.encode_int_char_couple(motora)
        speed_b = self.encode_int_char_couple(motorb)

        self._bus.write_i2c_block_data(
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

        self._bus.write_i2c_block_data(
            MOTOR_ADDRESS, 0,
            [
                MOTOR_COMMAND_SET_PWM,
                speed_a[0],
                speed_a[1],
                speed_b[0],
                speed_b[1]
            ]
        )   