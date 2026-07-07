# Overview
This project implements an 8-bit CPU with functions being shown on the Altera DE10-Lite FPGA. The design is intended to help develop a better understanding of processor architecture and function using the fundamental components - a program counter, instruction memory, instruction decoder, register file, ALU, and a control FSM.

This CPU receives the instructions from the ROM and decodes them into signals. Once the signals are recieved, they are mapped to their respective arithmetic / logical instructions and the outputs are written back to the register file. These behaviors were verified through testbenches and/or FPGA simulations. 

# CPU Architecture

                 +------------------+
                 | Program Counter  |
                 +--------+---------+
                          |
                          v
                 +------------------+
                 | Instruction ROM  |
                 +--------+---------+
                          |
                          v
                 +------------------+
                 | Instruction      |
                 | Decoder          |
                 +----+--------+----+
                      |        |
                      v        v
                  +---------------+
                  | Register File |
                  +------+--------+
                         |
                         v
                    +----------+
                    |   ALU    |
                    +----+-----+
                         |
                         v
                     Write Back

# Features
## CPU Components
- 8-bit Program Counter
- Instruction ROM
- Instruction Decoder
- Four 8-bit General Purpose Registers
- Arithmetic Logic Unit (ADD, SUB, AND, OR, XOR)
- Finite State Machine Controller
- Register Writeback Path

## Hardware Features
- Seven-segment display for Program Counter visualization
- LED debugging for instruction fields and CPU status
- Slow clock divider for observing instruction execution
  
# Instruction Set
| Opcode | Instruction | Description |
|--------|-------------|-------------|
| 000 | ADD | Adds two registers |
| 001 | SUB | Subtracts two registers |
| 010 | AND | Bitwise AND |
| 011 | OR | Bitwise OR |
| 100 | XOR | Bitwise XOR |
# Module Hierarchy
rtl/ 

cpu_demo.sv  
├── program_counter.sv  
├── instruction_memory.sv  
├── instruction_decoder.sv  
├── register_file.sv  
├── alu.sv  
├── control_fsm.sv  
└── seven_seg_decoder.sv  

sim/  
tb_program_counter.sv  
tb_instruction_decoder.sv  
tb_register_file.sv  
tb_alu.sv  

# Hardware Setup
## Hardware
- Altera DE10-Lite FPGA Board
- Intel MAX10 FPGA

## Software
- Intel Quartus Prime Lite
- ModelSim
- Visual Studio Code
  
# Verification
The following modules were verified through simulation and hardware testing:

| Module                | Simulation | Hardware |
| --------------------- | :--------: | :------: |
| ALU                   |      ✓     |     ✓    |
| Register File         |      ✓     |     -    |
| Program Counter       |      ✓     |     ✓    |
| Instruction Decoder   |      ✓     |     ✓    |
| Control FSM           |      ✓     |     ✓    |
| CPU_Demo              |      -     |     ✓    |


# Hardware Demonstration

# Lessons Learned
- CPU datapath design
- Register file implementation
- Instruction decoding
- Finite State Machine control
- ALU design
- Hardware verification
- FPGA debugging using LEDs
- Clock division
- Combinational vs sequential logic
- Modular hardware design

# Future Improvements
- Add RAM for data storage.
- Implement load/store instructions.
- Add conditional branches and jumps.
- Expand the register file.
- Support immediate instructions.
- Replace the ROM with a programmable instruction memory.
- Add UART-based program loading.
- Add pipeline stages.
- Add interrupts and exception handling.
