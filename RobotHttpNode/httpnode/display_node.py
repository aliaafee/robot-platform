from typing import Any
import digitalio
import board
from PIL import Image, ImageDraw
from adafruit_rgb_display import ili9341
import time
from threading import Thread

from node_server import start_server
from base_node import BaseNodeHandler, BaseNode

# Configuration for CS and DC pins (these are PiTFT defaults):
CS_PIN = digitalio.DigitalInOut(board.CE0)
DC_PIN = digitalio.DigitalInOut(board.D24)
RESET_PIN = digitalio.DigitalInOut(board.D25)

# Config for display baudrate (default max is 24mhz):
BAUDRATE = 24000000

DISPLAY_INTERVAL = 0.03


class Display():
    def __init__(self, fps=0) -> None:
        self.spi = board.SPI()

        self.display = ili9341.ILI9341(
            self.spi,
            rotation=90,  # 2.2", 2.4", 2.8", 3.2" ILI9341
            cs=CS_PIN,
            dc=DC_PIN,
            rst=RESET_PIN,
            baudrate=BAUDRATE,
        )

        if self.display.rotation % 180 == 90:
            self.height = self.display.width  # we swap height/width to rotate it to landscape!
            self.width = self.display.height
        else:
            self.width = self.display.width  # we swap height/width to rotate it to landscape!
            self.height = self.display.height

        self.image = Image.new("RGB", (self.width, self.height))
        self.draw = ImageDraw.Draw(self.image)

        self.running = False
        self.thread = Thread(target=self.thread_worker)

        if fps < 1:
            self.frame_inteval = None
        else:
            self.frame_inteval = 1.0 / fps

    def clear_image(self):
        self.draw.rectangle((0, 0, self.width, self.height),
                            outline=0, fill=(0, 0, 0))

    def update_display(self):
        self.display.image(self.image)

    def loop(self):
        self.clear_image()
        self.draw.ellipse(
            (20, 20, self.width - 20, self.height - 20), outline=0, fill=(100, 0, 0))
        self.update_display()

    def thread_worker(self):
        while self.running:
            self.loop()

            if self.frame_inteval is not None:
                time.sleep(self.frame_inteval)

    def start(self):
        self.running = True
        self.thread.start()

    def stop(self):
        self.running = False





class AnimatedPolygon:
    def __init__(self, points, lines, color) -> None:
        self.points = points
        self.lines = lines

        self.color = color

        self.start_points = points
        self.end_points = points
        self.start_time = 0
        self.end_time = 0

        pass


    def draw(self, image_draw):
        for line_start, line_end in self.lines:
            image_draw.line([self.points[line_start], self.points[line_end]], fill=self.color, width=0)


    def set_end_points(self, points, duration):
        if len(points) != len(self.points):
            print("invalid target points")
            return
        
        self.start_time = time.time()
        self.end_time = self.start_time + duration
        self.start_points = self.points
        self.end_points = points


    def interpolate(self):
        t = time.time()
        
        if t > self.end_time:
            self.points = self.end_points
            return
        
        dt = float(t - self.start_time) / float(self.end_time - self.start_time)

        points = []
        for i in range(len(self.points)):
            points.append((
                int(self.start_points[i][0] + dt * (self.end_points[i][0] - self.start_points[i][0])),
                int(self.start_points[i][1] + dt * (self.end_points[i][1] - self.start_points[i][1]))
            ))
        self.points = points



class Face(Display):
    def __init__(self, fps=0) -> None:
        super().__init__(fps)

        self.left_eye_elevation = 60
        self.right_eye_elevation = 60

        self.left_eye_size = 60
        self.right_eye_size = 60

        self.ipd = 150

        self.left_closed = False
        self.right_closed = False

        self.blink_interval = 5
        self.blink_duration = 0.5
        self.last_blink_time = time.time()

        self.p = AnimatedPolygon(
            points=[(100,150), (130,150), (190, 150), (220, 150)],
            lines=[(0, 1), (1, 2), (2, 3)],
            color=(255, 255, 255)
        )

        self.p.set_end_points(
            points=[(100,140), (130,150), (190, 150), (220, 140)],
            duration=0.5
        )

    def draw_eye(self, position, size, closed):
        if closed:
            self.draw.rectangle(
                (
                    position[0] - size/2,
                    position[1] - 2,
                    position[0] + size/2,
                    position[1] + 2
                ),
                outline=1, fill=(255, 255, 255)
            )
            return

        self.draw.ellipse(
            (
                position[0] - size/2,
                position[1] - size/2,
                position[0] + size/2,
                position[1] + size/2
            ),
            outline=1, fill=(255, 255, 255)
        )

    def loop(self):
        self.clear_image()

        now = time.time()
        if now > self.last_blink_time + self.blink_interval:
            self.right_closed = True
            self.left_closed = True
            if now > self.last_blink_time + self.blink_interval + self.blink_duration:
                self.right_closed = False
                self.left_closed = False
                self.last_blink_time = now

        self.draw_eye(
            (
                self.width/2 - self.ipd/2,
                self.right_eye_elevation
            ),
            self.right_eye_size,
            self.right_closed
        )

        self.draw_eye(
            (
                self.width/2 + self.ipd/2,
                self.left_eye_elevation
            ),
            self.left_eye_size,
            self.left_closed
        )

        self.p.interpolate()

        self.p.draw(self.draw)

        self.update_display()


display = Face(30)
display.start()

time.sleep(1000)

display.stop()


"""
# Setup SPI bus using hardware SPI:
spi = board.SPI()

disp = ili9341.ILI9341(
    spi,
    rotation=90,  # 2.2", 2.4", 2.8", 3.2" ILI9341
    cs=CS_PIN,
    dc=DC_PIN,
    rst=RESET_PIN,
    baudrate=BAUDRATE,
)

# Create blank image for drawing.
# Make sure to create image with mode 'RGB' for full color.
if disp.rotation % 180 == 90:
    height = disp.width  # we swap height/width to rotate it to landscape!
    width = disp.height
else:
    width = disp.width  # we swap height/width to rotate it to landscape!
    height = disp.height
image = Image.new("RGB", (width, height))

# Get drawing object to draw on image.
draw = ImageDraw.Draw(image)

# Draw a black filled box to clear the image.
draw.rectangle((0, 0, width, height), outline=0, fill=(0, 100, 0))
draw.ellipse((10, 10, 30, 40), outline=0, fill=(100, 0, 0))
disp.image(image)


image = Image.open("/home/rob/Pictures/blinka.jpg")

# Scale the image to the smaller screen dimension
image_ratio = image.width / image.height
screen_ratio = width / height
if screen_ratio < image_ratio:
    scaled_width = image.width * height // image.height
    scaled_height = height
else:
    scaled_width = width
    scaled_height = image.height * width // image.width
image = image.resize((scaled_width, scaled_height), Image.BICUBIC)

# Crop and center the image
x = scaled_width // 2 - width // 2
y = scaled_height // 2 - height // 2
image = image.crop((x, y, x + width, y + height))

# Display image.
disp.image(image)
"""
