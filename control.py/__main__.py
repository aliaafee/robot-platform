import serial
import curses


def main(stdscr):
    stdscr.nodelay(1)

    ser = serial.Serial(
            port = '/dev/cu.HC-07-DevB',
            #port = '/dev/cu.wchusbserial1410',
            baudrate=9600,
            timeout=1)

    ser.isOpen()

    while True:
        c = stdscr.getch()
        if c != -1:
            stdscr.addstr(str(c) + ' ')
            stdscr.move(0, 0)
            cmd = b's'
            if c == 259:
                #forward
                cmd = b'f'
            elif c == 258:
                #backward
                cmd = b'b'
            elif c == 261:
                #right
                cmd = b'r'
            elif c == 260:
                #left
                cmd = b'l'
            else:
                #stop
                cmd = b's'
            ser.write("{0}\n".format(cmd))
            result = ser.readline()
            stdscr.addstr('{0} '.format(result))
            stdscr.move(0,0)


if __name__ == '__main__':
    curses.wrapper(main)
