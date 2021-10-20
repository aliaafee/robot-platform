# Driver.pio

Firmware for robot driver.

TODO: Implement this as a finite state machine.

## Functions

Robot driver recieves commands over I2C bus(acts as I2C slave).
Performs basic functions such as movement and collision detection.
Acts as a state machine.

Example: when given command "move by x steps forward", 
sets internal state to "moving forward",
sets motor controller to move forwards,
starts counting steps using wheel encoder interrupts,
stops the motor and sets state to "stopped" when steps goal reached.
During this process robot driver is able to send status via I2C bus when
master makes a request. Robot driver also looks for collisions and stops
when collision detected and updates state appropriately and also sets an
error state.

## Build and Upload

* Install PlatformIO
* Install required depenencies `pio lib install`
* Update `board` and `upload_port` to appropriate values in `platformio.ini`
* Build `pio run`
* Upload to device `pio run -t upload`