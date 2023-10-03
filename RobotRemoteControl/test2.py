import cv2
import numpy as np

RTSP_STRING = 'http://robotpi.local:8001/stream.mjpg'

cap = cv2.VideoCapture(
    RTSP_STRING,
    apiPreference=cv2.CAP_ANY,
    params=[cv2.CAP_PROP_READ_TIMEOUT_MSEC, 1000],  # 1 second
)


def loop():
    global cap
    
    ret, frame = cap.read()

    if not ret:
        print("Error")
        cap = cv2.VideoCapture(
            RTSP_STRING,
            apiPreference=cv2.CAP_ANY,
            params=[cv2.CAP_PROP_READ_TIMEOUT_MSEC, 1000],  # 1 second
        )
        return

    hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
    lower_red = np.array([0, 100, 100])
    upper_red = np.array([10, 255, 255])
    mask = cv2.inRange(hsv, lower_red, upper_red)
    contours, _ = cv2.findContours(
        mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    cv2.imshow('Video', frame)


while True:

    loop()

    if cv2.waitKey(1) == 27:
        exit(0)
