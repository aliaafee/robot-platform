from robot_controller import RobotController
from control_server import ControlServer
from robot_state import RobotState

import logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s %(message)s')


# class GyroTest(RobotController):
#     def on_frame(self):
#         gyro_reading = [round(x, 2) for x in self.gyro.read()]
#         self.state.push_telemetry(
#             {'gyro': gyro_reading}
#         )


def main():
    logging.info("Robot Control Starting")

    state = RobotState()

    remote_control_server = ControlServer('0.0.0.0', 8000, state)
    remote_control_server.start()
    # remote_control_server.camera_recorder.start_recording()

    robot = RobotController(frequency=10, state=state)

    # robot.set_steering(100,-90)

    try:
        while True:
            robot.loop()
    except KeyboardInterrupt:
        remote_control_server.shutdown()
        logging.info("Stopping Robot Control")


if __name__ == '__main__':
    main()
