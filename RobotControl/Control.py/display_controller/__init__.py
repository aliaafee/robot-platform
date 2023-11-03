import digitalio
import board
from PIL import Image, ImageDraw
from adafruit_rgb_display import ili9341, rgb

BAUDRATE = 24000000


class DisplayController():
    def __init__(self, spi, rotation, cs_pin, dc_pin, reset_pin) -> None:
        self._bus = spi

        self.display = ili9341.ILI9341(
            self._bus,
            rotation=rotation,  # 2.2", 2.4", 2.8", 3.2" ILI9341
            cs=cs_pin,
            dc=dc_pin,
            rst=reset_pin,
            baudrate=BAUDRATE,
        )

        if self.display.rotation % 180 == 90:
            self.height = self.display.width  # we swap height/width to rotate it to landscape!
            self.width = self.display.height
        else:
            self.width = self.display.width  # we swap height/width to rotate it to landscape!
            self.height = self.display.height


    def clear(self, color=(0,0,0)):
        self.display.fill(color=rgb.color565(color[0], color[1], color[2]))
