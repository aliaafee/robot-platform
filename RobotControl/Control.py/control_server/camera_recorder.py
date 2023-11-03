import threading
import io
import picamera
import time
import logging


class StreamingOutput():
    def __init__(self) -> None:
        self.frame = None
        self.buffer = io.BytesIO()
        self.condition = threading.Condition()

    def write(self, buf):
        if buf.startswith(b'\xff\xd8'):
            # New frame, copy the existing buffer's content and notify all
            # clients it's available
            self.buffer.truncate()
            with self.condition:
                self.frame = self.buffer.getvalue()
                self.condition.notify_all()
            self.buffer.seek(0)
        return self.buffer.write(buf)


class CameraRecorder():
    def __init__(self, resolution, fps) -> None:
        self.resolution = resolution
        self.fps = fps
        self.output = StreamingOutput()
        self.recording = False

    def start_recording(self, join=False):
        if self.recording:
            return

        self.recording = True
        self.camera_thread = threading.Thread(target=self.camera_worker)
        self.camera_thread.start()

    def camera_worker(self):
        logging.info("Starting Camera Recording")
        with picamera.PiCamera(resolution=self.resolution, framerate=self.fps) as camera:
            camera.start_recording(self.output, format='mjpeg')

            while self.recording:
                time.sleep(1)
        logging.info("Stopping Camera Recording")

    def stop_recording(self):
        self.recording = False
