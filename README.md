# Calculator with FPGA

## Introduction 
* This project uses NEXYS DDR4 board to do integer calculation such as addition, subtraction, multiplication and division.

* A 4x4 keypad is used to do the operation, connected via Pmod Header.

* Please refer to the XDC file to view the connection of the Pmod header.

* A memory that's made up using registers can store the most recent 8 calculations done.

* To access the memory, hold the "=" key for 2 seconds to access the memory. Using "A" and "D" to cycle the memory.

* The calculation is displayed via the NEXYS DDR4 7-segement display.

## Program / Hardware requirements

### Program 
* Vivado 2019.1 version

> **Note**: Vivado 2019.1 version is not available anymore. Please use Vivado 2023 version from this [link](https://www.xilinx.com/support/download.html).

### Hardware
* Xilinx NEXYS A7 50T / 100T

* A 4x4 keypad. Keypad can be purchased via this [link](https://www.amazon.com/Matrix-Membrane-Keyboard-Arduino-MicrocontrollerWIshioT/dp/B07B4DR5SH/ref=asc_df_B07B4DR5SH/?tag=hyprod-20&linkCode=df0&hvadid=459641693740&hvpos=&hvnetw=g&hvrand=11472968615419084120&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9020068&hvtargid=pla-942741144682&psc=1&mcid=0634068134253779bfedfe6580e15e3c).


