import cv2
import numpy as np
import time
import threading
from queue import Queue

RTSP_STRING = 'http://robotpi.local:8001/stream.mjpg'


class CameraStream:
    def __init__(self, rtsp) -> None:
        self.capture = None
        self.rtsp = rtsp
        self.capture_queue = Queue(maxsize=1)
        self.running = False
        self.capture_tread = None

    def _capture_function(self):
        while self.running:
            # grabbed, frame = self.capture.read()
            grabbed = self.capture.grab()

            if not grabbed:
                continue

            if not self.capture_queue.full():
                grabbed, frame = self.capture.retrieve()

                if not grabbed:
                    continue

                self.capture_queue.put({
                    'frame': frame,
                    'time': time.time()
                })

        self.release()

    def release(self):
        if self.capture is None:
            return

        self.capture.release()
        self.capture = None

    def start(self):
        self.capture = cv2.VideoCapture(
            self.rtsp,
            apiPreference=cv2.CAP_ANY,
            params=[cv2.CAP_PROP_READ_TIMEOUT_MSEC, 1000]
        )

        self.capture_tread = threading.Thread(target=self._capture_function)

        self.running = True

        self.capture_tread.start()

    def stop(self):
        self.running = False

    def get_frame(self):
        if self.capture_queue.empty():
            return None, None
        frame = self.capture_queue.get()
        return frame['time'], frame['frame']


class VisualControl:
    def __init__(self, camera_stream) -> None:
        self.camera_stream = camera_stream
        self.prev_time = time.time()

    def start(self):
        self.camera_stream.start()

    def get_fps(self, frame_time):
        frame_duration = frame_time - self.prev_time
        self.prev_time = frame_time

        return round(1.0/frame_duration)

    def loop(self, show_image=True):
        frame_time, frame = self.camera_stream.get_frame()

        if frame is None:
            return

        self.process_frame(frame_time, frame)

        if not show_image:
            return

        cv2.putText(frame, text=f'fps {self.get_fps(frame_time)}', org=(
            10, 20), fontFace=cv2.FONT_HERSHEY_PLAIN, fontScale=1, color=(255, 255, 255))
        cv2.imshow('Video', frame)

    def stop(self):
        self.camera_stream.stop()

    def process_frame(self, frame_time, frame):
        pass


class ArucoControl(VisualControl):
    def __init__(self, camera_stream) -> None:
        super().__init__(camera_stream)

        aruco_dict = cv2.aruco.getPredefinedDictionary(cv2.aruco.DICT_4X4_250)
        parameters = cv2.aruco.DetectorParameters()
        self.detector = cv2.aruco.ArucoDetector(aruco_dict, parameters)

    def process_frame(self, frame_time, frame):
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        corners, ids, rejectedImgPoints = detector.detectMarkers(frame)

        target_position = ()

        if len(corners) > 0:
            #cv2.aruco.drawDetectedMarkers(frame, corners, ids)
            
            for corner, id in zip(corners, ids):
                print(id)
                print(corner)
                corner_center = [sum(column)/len(column) for column in zip(*corner[0])]
                print(corner_center)

                cv2.circle(frame, (int(corner_center[0]),int(corner_center[1])) , radius=5, color=(0,0, 2555), thickness=-1)



def process_frame(frame):
    hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
    lower_red = np.array([0, 100, 100])
    upper_red = np.array([10, 255, 255])
    mask = cv2.inRange(hsv, lower_red, upper_red)
    contours, _ = cv2.findContours(
        mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    if contours:
        largest_contour = max(contours, key=cv2.contourArea)

        x, y, w, h = cv2.boundingRect(largest_contour)

        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)

    time.sleep(0.1)


aruco_dict = cv2.aruco.getPredefinedDictionary(cv2.aruco.DICT_4X4_250)
parameters = cv2.aruco.DetectorParameters()
detector = cv2.aruco.ArucoDetector(aruco_dict, parameters)


def process_frame2(frame):
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    corners, ids, rejectedImgPoints = detector.detectMarkers(frame)

    if len(corners) > 0:
        cv2.aruco.drawDetectedMarkers(frame, corners, ids)


prev_time = time.time()


def loop(camera_stream):
    global prev_time

    last_time, frame = camera_stream.get_frame()

    if frame is None:
        return

    current_time = last_time
    frame_time = current_time - prev_time
    fps = round(1.0/frame_time)
    prev_time = current_time

    process_frame2(frame)

    cv2.putText(frame, text=f'fps {fps}', org=(
        10, 20), fontFace=cv2.FONT_HERSHEY_PLAIN, fontScale=1, color=(255, 255, 255))
    cv2.imshow('Video', frame)


def main():
    stream = CameraStream(RTSP_STRING)

    controller = ArucoControl(stream)

    controller.start()

    while True:
        controller.loop()

        if cv2.waitKey(1) == 27:
            controller.stop()
            exit(0)


if __name__ == "__main__":
    main()
