// CPU.tst
// Test script for CPU.hdl
// Run this in the Nand2Tetris Hardware Simulator

load CPU.hdl,
output-file CPU.out,
compare-to CPU.cmp,
output-list inM%D1.6.1 instruction%B1.16.1 reset%B1.1.1 outM%D1.6.1 writeM%B1.1.1 addressM%D1.6.1 pc%D1.6.1;

// Test 1: A-instruction — load value 5 into A-register
// instruction = 0 000000000000101 (A-instruction, value=5)
set instruction %B0000000000000101,
set reset 0,
tick, tock, output;

// Test 2: C-instruction — D = A (copy A into D)
// instruction = 1110110000010000
// comp=A (a=0, c=110000), dest=D (d2=1), jump=none
set instruction %B1110110000010000,
tick, tock, output;

// Test 3: C-instruction — D = D + A
// instruction = 1110000010010000
// comp=D+A, dest=D
set instruction %B1110000010010000,
tick, tock, output;

// Test 4: C-instruction — M[A] = D (write D to memory at address A)
// instruction = 1110001100001000
// comp=D, dest=M
set instruction %B1110001100001000,
set inM 0,
tick, tock, output;

// Test 5: Reset
set reset 1,
tick, tock, output;
set reset 0,
tick, tock, output;
