from dataclasses import dataclass, asdict
from typing import Tuple, List, Dict
from collections import deque


@dataclass
class Command:
    name: str
    arguments: List


@dataclass
class Telemetry:
    time: float
    gyro: Tuple[float, float, float]
    accel: Tuple[float, float, float]
    mag: Tuple[float, float, float]


class RobotState:
    def __init__(self) -> None:
        self.telemetry_queue = deque(maxlen=10)
        self.last_telemetry = None

        self.command_queue = deque()

    def push_telemetry(self, telemetry: Telemetry) -> None:
        self.telemetry_queue.append(telemetry)

    def get_telemetry(self) -> Telemetry:
        try:
            return self.telemetry_queue[-1]
        except IndexError:
            return None

    def get_telemetry_asdict(self) -> Dict:
        telemetry = self.get_telemetry()
        if telemetry is None:
            return None
        return asdict(telemetry)

    def push_command(self, command: Command) -> None:
        self.command_queue.append(command)

    def get_command(self) -> Command:
        try:
            return self.command_queue.popleft()
        except IndexError:
            return None
