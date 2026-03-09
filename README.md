# 16-Bit CPU Architecture — HDL Implementation

A complete 16-bit CPU architecture designed and implemented in Hardware Description Language (HDL), compatible with the [Nand2Tetris Hardware Simulator](https://www.nand2tetris.org/software). Built as a portfolio project demonstrating digital systems design, computer architecture fundamentals, and hardware engineering skills.

---

## Overview

This project implements a simplified but fully functional 16-bit von Neumann CPU from the ground up using HDL. The architecture supports:

- A-instructions (load immediate values / set addresses)
- C-instructions (compute, store, jump)
- ALU operations: addition, bitwise AND, NOT, negation, and more
- Conditional and unconditional jumps
- Memory-mapped I/O (RAM, Screen, Keyboard)

---

## Architecture Diagram

```
         +------------------+
         |     ROM32K       |  <-- Instruction Memory
         |  (Program Store) |
         +--------+---------+
                  | instruction[16]
                  v
         +------------------+        +------------------+
  inM -->|                  |-outM-->|     Memory       |
         |       CPU        |        | (RAM + Screen    |
  reset->|                  |-writeM>|  + Keyboard)     |
         |  [A-reg][D-reg]  |        +------------------+
         |      [ALU]       |
         |      [PC ]       |
         +--------+---------+
                  | pc[15]
                  v
              (feeds back to ROM32K address)
```

---

## Project Structure

```
cpu16bit/
├── hdl/
│   ├── ALU.hdl         # Arithmetic Logic Unit
│   ├── Register.hdl    # 16-bit general purpose register
│   ├── PC.hdl          # Program Counter
│   ├── CPU.hdl         # Main CPU (control logic)
│   ├── Memory.hdl      # Unified memory interface
│   └── Computer.hdl    # Top-level: CPU + ROM + Memory
├── test/
│   ├── ALU.tst         # ALU test script
│   ├── ALU.cmp         # ALU expected output
│   ├── CPU.tst         # CPU test script
│   └── CPU.cmp         # CPU expected output
├── docs/
│   └── instruction_set.md  # Instruction format reference
└── README.md
```

---

## Key Components

### ALU (ALU.hdl)
The Arithmetic Logic Unit performs all computation in the CPU. It takes two 16-bit inputs (x, y) and six control bits that determine the operation:

| zx | nx | zy | ny | f | no | Operation  |
|----|----|----|----|----|-----|------------|
| 1  | 0  | 1  | 0  | 1 | 0   | 0          |
| 1  | 1  | 1  | 1  | 1 | 1   | 1          |
| 1  | 1  | 1  | 0  | 1 | 0   | -1         |
| 0  | 0  | 1  | 1  | 0 | 0   | x          |
| 0  | 0  | 0  | 0  | 1 | 0   | x + y      |
| 0  | 1  | 0  | 0  | 1 | 1   | x - y      |
| 0  | 0  | 0  | 0  | 0 | 0   | x AND y    |
| 0  | 1  | 0  | 1  | 0 | 1   | x OR y     |

Output flags: `zr` (result is zero), `ng` (result is negative).

---

### Register (Register.hdl)
A 16-bit clocked storage element built from DFF (Data Flip-Flop) units. Stores a value when `load=1`, holds its current value otherwise. Used for both the A-register and D-register inside the CPU.

---

### Program Counter (PC.hdl)
Tracks which instruction the CPU should fetch next. Priority logic:
1. `reset=1` → output 0 (restart program)
2. `load=1` → output the jump address
3. `inc=1` → output current + 1 (next instruction)
4. Otherwise → hold current value

---

### CPU (CPU.hdl)
The main control unit. Decodes each instruction and coordinates the A-register, D-register, ALU, and Program Counter.

**Instruction Format:**

```
A-instruction: 0 v v v v v v v v v v v v v v v   (load value into A)
C-instruction: 1 1 1 a c1 c2 c3 c4 c5 c6 d1 d2 d3 j1 j2 j3
               ^     ^ ^-ALU ctrl--^ ^-dest-^ ^-jump-^
               |     |
               |     a=0: ALU uses A-register
               |     a=1: ALU uses Memory[A]
               C-instruction flag
```

**Destination bits (d1 d2 d3):**
- d1=1: Store result in A-register
- d2=1: Store result in D-register
- d3=1: Write result to Memory[A]

**Jump bits (j1 j2 j3):**
- j1=1: Jump if result < 0
- j2=1: Jump if result = 0
- j3=1: Jump if result > 0

---

### Memory (Memory.hdl)
Unified 32K address space:
- `0 – 16383`: RAM (general data)
- `16384 – 24575`: Screen (memory-mapped display)
- `24576`: Keyboard (read-only input register)

---

### Computer (Computer.hdl)
Top-level chip connecting CPU, ROM (instruction memory), and Memory (data memory) into a complete working computer.

---

## How to Run

1. Download the [Nand2Tetris Software Suite](https://www.nand2tetris.org/software)
2. Open the **Hardware Simulator**
3. Load any `.hdl` file from the `/hdl` folder
4. Load the corresponding `.tst` file from `/test`
5. Click **Run** to execute the test and compare against `.cmp`

---

## Skills Demonstrated

- Digital logic design (combinational and sequential circuits)
- HDL hardware description and simulation
- CPU architecture: fetch-decode-execute cycle
- ALU design and control bit encoding
- Memory-mapped I/O architecture
- Technical documentation and test-driven hardware verification

---

## References

- Nisan, N. & Schocken, S. — *The Elements of Computing Systems* (Nand2Tetris)
- Patterson & Hennessy — *Computer Organization and Design*

---

*Developed by Michael Kalu — Electrical Engineering Student, Grambling State University*
