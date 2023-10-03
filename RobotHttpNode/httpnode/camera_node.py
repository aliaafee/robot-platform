import logging
import io
import picamera
from threading import Condition

from base_node import BaseNodeHandler, BaseNode
from node_server import start_server

CAMERA_RESOLUTION = '320x240'
CAMERA_FPS = 24

PAGE = """\
<!DOCTYPE html>
<html>
<head>
    <title>Camera Stream</title>
</head>
<body>
    <h1>Camera Stream</h1>
    <img src="stream.mjpg" width="640" height="480" />
</body>
</html>
"""

class StreamingOutput(object):
    def __init__(self):
        self.frame = None
        self.buffer = io.BytesIO()
        self.condition = Condition()

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


output = StreamingOutput()


class CameraNodeHandler(BaseNodeHandler):
    def send_stream(self):
        self.send_response(200)
        self.send_header('Age', '0')
        self.send_header('Cache-Control', 'no-cache, private')
        self.send_header('Pragma', 'no-cache')
        self.send_header('Content-Type', 'multipart/x-mixed-replace; boundary=FRAME')
        self.end_headers()
        try:
            while True:
                with output.condition:
                    output.condition.wait()
                    frame = output.frame
                self.wfile.write(b'--FRAME\r\n')
                self.send_header('Content-Type', 'image/jpeg')
                self.send_header('Content-Length', len(frame))
                self.end_headers()
                self.wfile.write(frame)
                self.wfile.write(b'\r\n')
        except Exception as e:
            logging.warning(
                'Removed streaming client %s: %s',
                self.client_address, str(e))


    def handle_GET(self, url):
        if url.path == '/':
            self.send_redirect('/index.html')
        elif url.path == '/index.html':
            self.send_text(PAGE)
        elif url.path == '/stream.mjpg':
            self.send_stream()
        else:
            self.send_notfound()

        
class CameraNode(BaseNode):
    def start(self, address):
        with picamera.PiCamera(resolution=CAMERA_RESOLUTION, framerate=CAMERA_FPS) as camera:
            camera.start_recording(output, format='mjpeg')

            start_server(address, CameraNodeHandler)
