

class PIDController:
    def __init__(self, kp: float, ki: float, kd: float, output_min: float, output_max: float) -> None:
        self.kp = kp
        self.ki = ki
        self.kd = kd
        self.setpoint = 0
        self.prev_error = 0
        self.integral = 0

        self.output_min = output_min
        self.output_max = output_max
        self.output = 0

    def update_setpoint(self, setpoint: float) -> None:
        self.setpoint = setpoint

    def get_output(self, current_value: float) -> float:
        error = self.setpoint - current_value
        self.integral += error
        derivative = error - self.prev_error
        self.output = self.kp * error + self.ki * self.integral + self.kd * derivative
        self.prev_error = error

        if self.output > self.output_max:
            return self.output_max

        if self.output < self.output_min:
            return self.output_min

        return self.output
