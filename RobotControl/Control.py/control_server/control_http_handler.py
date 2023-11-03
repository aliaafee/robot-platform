from http import server
import json
from urllib.parse import urlparse, parse_qs
import logging

from .camera_recorder import CameraRecorder
from robot_state import RobotState, Command

PAGE = """\
<!DOCTYPE html>
<html>

<head>
  <title>Remote Control</title>
  <script>
    const KEY_UP = 38;
    const KEY_DOWN = 40;
    const KEY_LEFT = 37;
    const KEY_RIGHT = 39;

    var pressedKeys = {};

    async function setStatus(message) {
      const status_el = document.getElementById("status");
      status_el.innerText = message;
    }

    async function setMotorSpeed(motora, motorb) {
      fetch("/set_motor_speed" + "?a=" + motora + "&b=" + motorb);
    }

    async function stopMotors(motora, motorb) {
      fetch("/stop_motors");
    }

    async function processKeys() {
      var moving = true;

      const forwardSpeed = document.getElementById('forward_speed').value;
      const turnSpeed = document.getElementById('turn_speed').value;

      if (pressedKeys[KEY_UP]) {
        setStatus("Forward");
        setMotorSpeed(forwardSpeed, -forwardSpeed);
        return;
      }

      if (pressedKeys[KEY_DOWN]) {
        setStatus("Backward");
        setMotorSpeed(-forwardSpeed, forwardSpeed);
        return;
      }

      if (pressedKeys[KEY_RIGHT]) {
        setStatus("Turn Right");
        setMotorSpeed(turnSpeed, turnSpeed);
        return;
      }

      if (pressedKeys[KEY_LEFT]) {
        setStatus("Turn Left");
        setMotorSpeed(-turnSpeed, -turnSpeed);
        return;
      }

      setStatus("Stop");
      stopMotors();
    }

    async function onKeyDown(e) {
      if (pressedKeys[e.keyCode]) {
        return;
      }
      pressedKeys[e.keyCode] = true;
      processKeys();
    }

    async function onKeyUp(e) {
      pressedKeys[e.keyCode] = false;
      processKeys();
    }

    async function loop() {
      processKeys();
    }

    document.addEventListener('keyup', onKeyUp);
    document.addEventListener('keydown', onKeyDown);
    setInterval(loop, 1000);

  </script>
</head>

<body>
  <h1>Remote Control</h1>
  <img src="camera_stream.mjpg" width="640" height="480" />
  <div>Forward Speed: <input id="forward_speed" value ="150" type="number"/> </div>
  <div>Turn Speed: <input id="turn_speed" value ="100" type="number"/> </div>
  <span id="status"></span>
</body>

</html>
"""


class BaseControlHTTTPHandler(server.BaseHTTPRequestHandler):
    def log_message(self, format, *args):
        logging.info(
            f"{self.client_address[0]}:{self.client_address[1]} {' '.join(args)}")

    def send_text(self, text):
        content = text.encode('utf-8')
        self.send_response(200)
        self.send_header('Content-Type', 'text/html')
        self.send_header('Content-Length', len(content))
        self.end_headers()
        self.wfile.write(content)

    def send_json(self, dictionary):
        content = json.dumps(dictionary).encode('utf-8')
        self.send_response(200)
        self.send_header('Content-Type', 'text/json')
        self.send_header('Content-Length', len(content))
        self.end_headers()
        self.wfile.write(content)

    def send_status_json(self, status):
        self.send_json(
            {
                'status': status
            }
        )

    def send_error_json(self, message):
        self.send_json(
            {
                'error': message
            }
        )

    def send_redirect(self, redirect_to):
        self.send_response(301)
        self.send_header('Location', redirect_to)
        self.end_headers()

    def send_notfound(self):
        self.send_error(404)
        self.end_headers()

    def do_GET(self):
        self.handle_GET(urlparse(self.path))


def create_handler(robot_state: RobotState, camera_recorder: CameraRecorder):
    class ControlHTTPHandler(BaseControlHTTTPHandler):
        def handle_GET(self, url):
            if url.path == '/':
                self.send_redirect('/index.html')
            elif url.path == '/index.html':
                self.send_text(PAGE)
            elif url.path == '/telemetry':
                self.handle_telemetry(url)
            elif url.path == '/set_motor_speed':
                self.handle_set_motor_speed(url)
            elif url.path == '/stop_motors':
                self.handle_stop_motors(url)
            elif url.path == '/start_camera_stream':
                camera_recorder.start_recording()
            elif url.path == '/stop_camera_stream':
                camera_recorder.stop_recording()
            elif url.path == '/camera_stream.mjpg':
                self.handle_camera_stream(url)
            else:
                self.send_notfound()

        def handle_telemetry(self, url):
            self.send_json(robot_state.get_telemetry_asdict())

        def get_motor_speed(self, query):
            motor_a = None
            motor_b = None

            q = parse_qs(query)
            if 'a' in q:
                motor_a = int(q['a'][0])

            if 'b' in q:
                motor_b = int(q['b'][0])

            return motor_a, motor_b

        def handle_set_motor_speed(self, url):
            robot_state.push_command(
                Command('set_motor_speed', self.get_motor_speed(url.query))
            )
            self.send_json(
                {
                    'status': 'set_motor_speed command queued'
                }
            )

        def handle_stop_motors(self, url):
            robot_state.push_command(
                Command('stop_motors', ())
            )
            self.send_json(
                {
                    'status': 'stop_motors command queued'
                }
            )

        def handle_camera_stream(self, url):
            self.send_response(200)
            self.send_header('Age', '0')
            self.send_header('Cache-Control', 'no-cache, private')
            self.send_header('Pragma', 'no-cache')
            self.send_header(
                'Content-Type', 'multipart/x-mixed-replace; boundary=FRAME')
            self.end_headers()
            try:
                while True:
                    with camera_recorder.output.condition:
                        camera_recorder.output.condition.wait()
                        frame = camera_recorder.output.frame
                    self.wfile.write(b'--FRAME\r\n')
                    self.send_header('Content-Type', 'image/jpeg')
                    self.send_header('Content-Length', len(frame))
                    self.end_headers()
                    self.wfile.write(frame)
                    self.wfile.write(b'\r\n')
            except Exception as e:
                logging.warning(
                    f'Removed streaming client {self.client_address}: {str(e)}')

    return ControlHTTPHandler
