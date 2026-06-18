# Overview
This project features both a DSP display and a UART implementation using SystemVerilog in Intel Quartus Prime Lite, Arduino IDE, VSCode, an Altera DE-10Lite FPGA board, and a CP2102 USB Serial Converter.

## Main Block Diagram for UART

                  PC Terminal 
                       |  
                       v
                +-------------+  
                |   UART RX   |  
                +-------------+
                       |  
                       v  
                +-------------+  
                |    FIFO     |  
                +-------------+  
                       |  
                       v  
                +-------------+  
                |  Processor  |  
                +-------------+  
                       |  
                       v  
                +-------------+  
                | Response FSM|  
                +-------------+  
                       |  
                       v  
                +-------------+  
                |   UART TX   |  
                +-------------+  
                       |  
                       v  
                  PC Terminal  

# Features
## UART Subsystem
- UART Transmitter (115200 baud)
- UART Receiver (115200 baud)
- Lowercase-to-uppercase ASCII processing
- FIFO buffering for received data
- Command detection and parsing
- Multi-character response generation using an FSM

## Supported Commands

| Command | Response |
|----------|----------|
| H | HELP |
| D | DEBUG |
| F | FILTER |
| L | LED |

## DSP Subsystem
- Moving Average Filter
- Clock Divider
- Seven-Segment Display Visualization
- Switch-Controlled Input Data

# System Architecture

The design is divided into two independent subsystems:

1. DSP Demonstration 
2. UART Communication 

The DSP platform demonstrates digital signal processing concepts using a moving average filter and visualizes results on the DE10-Lite board's LEDs and HEX Displays.

The UART platform receives ASCII commands from a PC through a CP2102 USB-to-UART converter. Incoming bytes are buffered using a FIFO, processed by a command parser, and transmitted back through a response FSM.
Arduino IDE was used to test UART inputs and outputs. 


# Module Hierarchy

top.sv   
├── clock_divider.sv  
├── moving_average.sv  
├── seven_seg_decoder.sv (multiple instances)  
└── uart_demo.sv  
&emsp; &nbsp; &nbsp;     ├── uart_rx.sv  
&emsp; &nbsp; &nbsp;    ├── uart_tx.sv  
&emsp; &nbsp; &nbsp;    ├── uart_processor.sv  
&emsp; &nbsp; &nbsp;    ├── uart_response_sender.sv  
&emsp; &nbsp; &nbsp;    ├── uart_fifo.sv  
&emsp; &nbsp; &nbsp;    └── seven_seg_decoder.sv  

<img width="1862" height="412" alt="image" src="https://github.com/user-attachments/assets/8a58f566-e068-49d5-bbe1-ba0834262903" />


    
# Component Setup
## Hardware
- Altera DE10-Lite FPGA Board
- Intel MAX10 FPGA
- CP2102 USB-UART Converter

## Software
- Intel Quartus Prime Lite
- ModelSim
- Arduino Serial Monitor
- Visual Studio Code

# Verification

The following modules were verified through simulation and hardware testing:

| Module                | Simulation | Hardware |
| --------------------- | :--------: | :------: |
| UART TX               |      ✓     |     ✓    |
| UART RX               |      ✓     |     ✓    |
| UART Processor        |      ✓     |     ✓    |
| UART Response FSM     |      ✓     |     ✓    |
| UART FIFO             |      ✓     |     ✓    |
| Moving Average Filter |      ✓     |     ✓    |
| Seven Segment Decoder |      ✓     |     ✓    |

Hardware testing was performed using an Intel DE10-Lite FPGA board and a CP2102 USB-to-UART converter. UART communication was validated using the Arduino Serial Monitor at 115200 baud.

Here is an example of the FIFO testbench running in ModelSim:
<img width="1918" height="1005" alt="image" src="https://github.com/user-attachments/assets/961dc60d-51bf-4847-8255-01ed5c6ff1e4" />

# Lessons Learned

- UART frame construction and LSB-first transmission
- Baud rate generation and timing constraints
- Finite State Machine design and debugging
- FIFO implementation using memory arrays and pointers
- Sequential versus combinational logic behavior
- Nonblocking assignment timing
- One-cycle pulse generation
- Hardware bring-up and debugging
- Hierarchical module design
- Testbench development and verification

# Future Improvements

* Add additional UART commands and responses.
* Implement a command menu and help system.
* Expand the FIFO to support larger buffer depths.
* Add CRC or parity checking for error detection.
* Create a VGA or LCD visualization interface.
* Support configurable baud rates.
* Improve FIFO read control with a dedicated consumer FSM.
* Add waveform screenshots and block diagrams to the documentation.
* Create additional testbenches with self-checking assertions.
* Extend the DSP subsystem with additional digital filters.

