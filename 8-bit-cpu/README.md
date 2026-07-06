# Overview

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
                  +-------+-------+
                         |
                         v
                    +----------+
                    |   ALU    |
                    +----+-----+
                         |
                         v
                     Write Back

# Features

# Instruction Set
| Opcode | Instruction | Description |
|--------|-------------|-------------|
| 000 | ADD | Adds two registers |
| 001 | SUB | Subtracts two registers |
| 010 | AND | Bitwise AND |
| 011 | OR | Bitwise OR |
| 100 | XOR | Bitwise XOR |
# Module Hierarchy

# Hardware Setup

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

# Future Improvements
