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

      // const forwardSpeed = document.getElementById('forward_speed').value;
      const turnSpeed = document.getElementById('turn_speed').value;

      const a_speed = document.getElementById('a_speed').value;
      const factor = document.getElementById('factor').value;
      const b_speed = Math.round(a_speed * factor);
      document.getElementById('b_speed').value = b_speed


      if (pressedKeys[KEY_UP]) {
        setStatus("Forward");
        setMotorSpeed(a_speed, -b_speed);
        return;
      }

      if (pressedKeys[KEY_DOWN]) {
        setStatus("Backward");
        setMotorSpeed(-a_speed, b_speed);
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

    async function getTelemetry() {
        const response = await fetch('/telemetry');
        const telemetry = await response.json();
        return telemetry;
    }

    async function onKeyUp(e) {
      pressedKeys[e.keyCode] = false;
      processKeys();
    }

    async function loop() {
      processKeys();
    }

    async function monitor_loop() {
      

      const telemetry = await getTelemetry();
      const x_rot = telemetry['orientation_angles'][0] * 180 / Math.PI;
      const y_rot = telemetry['orientation_angles'][1] * 180 / Math.PI;
      const z_rot = telemetry['orientation_angles'][2] * 180 / Math.PI;

      const heading = z_rot + 180;
      const compass_elem = document.getElementById('compass');
      compass_elem.setAttribute('transform', `translate(50, 50) rotate(${heading} 0 0)`);

      const heading_elem = document.getElementById('heading');
      heading_elem.innerText = Math.round(heading);

      const motor_elem = document.getElementById('motor');
      if (telemetry['motor_controller']!== "none") {
        motor_elem.innerText = telemetry['time'] + " ,motora_speed"+ telemetry['motor_controller']['motora_speed'] + ", motora_position=" + telemetry['motor_controller']['motora_counter'] + ", motorb_speed"+ telemetry['motor_controller']['motorb_speed'] + ", motorb_position=" + telemetry['motor_controller']['motorb_counter'];
      }

      const message_elem = document.getElementById('message');
      message_elem.innerText = telemetry['message'];
    }

    async function onStartStream() {
        await fetch("/start_camera_stream");

        setTimeout(() => {
            const img_stream = document.getElementById('img-stream');
            img_stream.src = `/camera_stream.mjpg?${Date.now()}`;
        }, 1000)

        
    }

    async function onStopStream() {
        await fetch("/stop_camera_stream");

        setTimeout(() => {
            const img_stream = document.getElementById('img-stream');
            img_stream.src = `/nothing`;
        }, 1000)
    }

    document.addEventListener('keyup', onKeyUp);
    document.addEventListener('keydown', onKeyDown);
    setInterval(loop, 1000);
    setInterval(monitor_loop, 100);

  </script>
</head>

<body>
  <h1>Remote Control</h1>
  <img id="img-stream" onClick="onImageStreamClick()" src="/nothing" width="640" height="480" />
  <button onClick="onStartStream()">Start Camera Stream</button>
  <button onClick="onStopStream()">Stop Camera Stream</button>
  <!-- <div>Forward Speed: <input id="forward_speed" value ="150" type="number"/> </div> -->
  <div>Turn Speed: <input id="turn_speed" value ="20" type="number"/> </div>
  <div> A Speed: <input id="a_speed" type="number" value="20"> </div>
  <div> Factor: <input id="factor" type="number" value="1"> </div>
  <div> B Speed: <input id="b_speed" type="number" value="150" disabled> </div>

  <div id="telemetry">
    <div>
      <div>Heading:<span id="heading"></span></div>
      <svg width="100" height="100" xmlns="http://www.w3.org/2000/svg">
          <polygon id="compass" points="-10,10 0,-10, 10,10 0,0" transform="" fill="red"/>
      </svg>
    </div>
    <div>
      <div>Motor Stat:<span id="motor"></span></div>
      <div>Message:<span id="message"></span></div>
    </div>
  </div>

  <div id="status_bar">
    <span id="status"></span>
  </div>
</body>

</html>
"""


class BaseControlHTTTPHandler(server.BaseHTTPRequestHandler):
    def log_message(self, format, *args):
        logging.debug(
            f"{self.client_address[0]}:{self.client_address[1]} {' '.join([str(a) for a in args])}")

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
                return

            url_map = {
                '/index.html': self.handle_index,
                '/telemetry': self.handle_telemetry,
                '/set_motor_speed': self.handle_set_motor_speed,
                '/set_steering': self.handle_set_steering,
                '/stop_motors': self.handle_stop_motors,
                '/start_camera_stream': self.handle_start_camera_stream,
                '/stop_camera_stream': self.handle_stop_camera_stream,
                '/camera_stream.mjpg': self.handle_camera_stream
            }

            if url.path not in url_map:
                self.send_notfound()
                return

            url_map[url.path](url)

        def handle_index(self, url):
            self.send_text(PAGE)

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

        def handle_set_steering(self, url):
            speed = 0
            angle = 0

            q = parse_qs(url.query)
            if 'speed' in q:
                speed = float(q['speed'][0])
            if 'angle' in q:
                angle = float(q['angle'][0])

            robot_state.push_command(
                Command('set_steering', (speed, angle))
            )

            self.send_json(
                {
                    'status': 'set_steering command queued'
                }
            )

        def handle_start_camera_stream(self, url):
            camera_recorder.start_recording()
            self.send_json(
                {
                    'status': 'start recording'
                }
            )

        def handle_stop_camera_stream(self, url):
            camera_recorder.stop_recording()
            self.send_json(
                {
                    'status': 'stop recording'
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
