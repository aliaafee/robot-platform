from robot_controller import RobotController
from control_server import ControlServer
from robot_state import RobotState
from pid_controller import PIDController

import sys
import getopt
import logging
logging.basicConfig(level=logging.ERROR,
                    format='%(asctime)s: %(threadName)s: %(message)s')


# class GyroTest(RobotController):
#     def on_frame(self):
#         gyro_reading = [round(x, 2) for x in self.gyro.read()]
#         self.state.push_telemetry(
#             {'gyro': gyro_reading}
#         )

# class StraightLineRobot(RobotController):
#     def __init__(self, frequency, state) -> None:
#         super().__init__(frequency, state)
#         self.steering_controller = PIDController(20, 0, 0, -90, 90)
#         self.steering_controller.update_setpoint(0)

#     def on_frame(self):
#         new_steering_angle = self.steering_controller.get_output(self.current_telemetry.gyro[2])
#         print(self.current_telemetry.gyro[2])
#         print(new_steering_angle)
#         self.set_steering(100, new_steering_angle)

def app_license():
    """ App license """
    print("Robot Control")


def usage(argv):
    """App Usage"""
    app_license()
    print(f"Usage: {argv[0]}")
    print("    -h, --help")
    print("       Displays this help")


def main(argv):
    try:
        opts, args = getopt.getopt(argv, "h", ["help"])
    except getopt.GetoptError:
        usage(argv)
        sys.exit(2)

    loglevel_debug = False

    for opt, arg in opts:
        if opt in ("-h", "--help"):
            usage(argv)
            sys.exit()
        if opt in ("-d", "--debug"):
            loglevel_debug = True

    # if loglevel_debug:
    #     logging.basicConfig(level=logging.DEBUG, format='%(asctime)s %(threadName)s %(message)s')
    # else:
    #     logging.basicConfig(level=logging.ERROR, format='%(asctime)s %(threadName)s %(message)s')

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
    main(sys.argv)
    # main()
