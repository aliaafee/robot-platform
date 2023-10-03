from urllib.parse import urlparse, parse_qs
import smbus

from node_server import start_server
from base_node import BaseNodeHandler, BaseNode


DEVICE_ID = 0x09
COMMAND_SET_SPEED = 0x4D
COMMAND_SET_PWM = 0x50
COMMAND_STOP = 0x53

PAGE = """\
<!DOCTYPE html>
<html>

<head>
  <title>Motor Control</title>
  <script>
    const KEY_UP = 38;
    const KEY_DOWN = 40;
    const KEY_LEFT = 37;
    const KEY_RIGHT = 39;

    var forwardSpeed = 150;
    var turnSpeed = 100;

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
  <h1>Motor Control</h1>
  <span id="status"></span>
</body>

</html>
"""


bus = smbus.SMBus(1)


def encode_int_char_couple(value):
    char1 = (value >> 8) & 0xFF
    char2 = value & 0xFF
    return char1, char2


def set_motor_speed(motora, motorb):
    speed_a = encode_int_char_couple(motora)
    speed_b = encode_int_char_couple(motorb)

    bus.write_i2c_block_data(
        DEVICE_ID, 0,
        [
            COMMAND_SET_SPEED,
            speed_a[0],
            speed_a[1],
            speed_b[0],
            speed_b[1]
        ]
    )


def set_motor_pwm(motora, motorb):
    speed_a = encode_int_char_couple(motora)
    speed_b = encode_int_char_couple(motorb)

    bus.write_i2c_block_data(
        DEVICE_ID, 0,
        [
            COMMAND_SET_PWM,
            speed_a[0],
            speed_a[1],
            speed_b[0],
            speed_b[1]
        ]
    )


def read_status():
    result = []
    for i in range(10):
        item = bus.read_byte(DEVICE_ID)
        result.append(item)
    return result


class MotorNodeHandler(BaseNodeHandler):
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
        motor_a, motor_b = self.get_motor_speed(url.query)

        if (motor_a is None) or (motor_b is None):
            self.send_json(
                {
                    'error': "Invalid Speed"
                }
            )
            return

        set_motor_speed(motor_a, motor_b)

        self.send_json(
            {
                'motor_a_speed': motor_a,
                'motor_b_speed': motor_b
            }
        )

    def handle_set_motor_pwm(self, url):
        motor_a, motor_b = self.get_motor_speed(url.query)

        if (motor_a is None) or (motor_b is None):
            self.send_json(
                {
                    'error': "Invalid PWM"
                }
            )
            return

        set_motor_speed(motor_a, motor_b)

        self.send_json(
            {
                'motor_a_pwm': motor_a,
                'motor_b_pwm': motor_b
            }
        )

    def handle_stop_motor(self, url):
        set_motor_pwm(0, 0)

        self.send_json(
            {
                'motor_a_pwm': 0,
                'motor_b_pwm': 0
            }
        )

    def handle_GET(self, url):
        if url.path == '/':
            self.send_redirect('/index.html')
        elif url.path == '/index.html':
            self.send_text(PAGE)
        elif url.path == '/set_motor_speed':
            self.handle_set_motor_speed(url)
        elif url.path == '/set_motor_pwm':
            self.handle_set_motor_pwm(url)
        elif url.path == '/stop_motors':
            self.handle_stop_motor(url)
        else:
            self.send_notfound()


class MotorNode(BaseNode):
    def start(self, address):
        start_server(address, MotorNodeHandler)
