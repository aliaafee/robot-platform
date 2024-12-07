
from http import server

import socketserver
import threading
import logging

from .camera_recorder import CameraRecorder
from .control_http_handler import create_handler


class ControlHTTPServer(socketserver.ThreadingMixIn, server.HTTPServer):
    allow_reuse_address = True
    daemon_threads = True


class ControlServer():
    def __init__(self, host, port, robot_state) -> None:
        self.camera_recorder = CameraRecorder(resolution="320x240", fps=24)

        self.server = ControlHTTPServer(
            (host, port), create_handler(robot_state=robot_state, camera_recorder=self.camera_recorder))

    def start(self, join=False):
        self.server_thread = threading.Thread(target=self.server_worker, name="ControlServerThread")

        self.server_thread.start()

        if join:
            self.server_thread.join()

    def server_worker(self):
        try:
            logging.info("Starting Remote Control Server")
            self.server.serve_forever()
        except:
            logging.info("Stopping Remote Control Server")
            self.server.shutdown()

    def shutdown(self):
        logging.info("Stopping Remote Control Server")
        self.camera_recorder.stop_recording()
        self.server.shutdown()
