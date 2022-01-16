# Sending RS232 frame : FPGA to Terminal
## Description
In this Lab, a character list is sent to the terminal of a computer via UART serial bus. We used a state machine which allows to send a character following 
a frame of type: 9600 bauds, 8 bits of data, no parity bit and 1 stop bit. RS232 connector is used to establish connection between FPGA board and the computer.
## Source files
| File | Type | Description |
| --- | --- | --- |
| Top_level.vhd | VHDL | The top level module |
| TX_fsm.vhd | VHDL | FSM implementation of transmit operation |
| Clk_generator.vhd | VHDL | Frequency divider |
| rom.vhd | VHDL | ROM to store data to be transmitted |
| Sending.vhd | VHDL | Component that reads ROM and sends characters to the transmitter |
