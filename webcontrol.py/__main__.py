import serial

from bottle import route, run, static_file, template

ser = serial.Serial(
            port = '/dev/cu.HC-07-DevB',
            #port = '/dev/cu.wchusbserial1410',
            baudrate=9600,
            timeout=1)


def sendCommand(command):
    ser.write("{0}\n".format(command))
    result = ser.readline()
    print "Serial: {0}".format(result)
    return result;


@route('/')
def index():
    return static_file("index.html", "res", mimetype="text/html")


@route('/f')
def forward():
    return sendCommand("f");


@route('/b')
def forward():
    return sendCommand("b");


@route('/r')
def forward():
    return sendCommand("r");


@route('/l')
def forward():
    return sendCommand("l");


@route('/s')
def forward():
    return sendCommand("s");


if __name__ == '__main__':
    run(host='localhost', port=8080, debug=True)
