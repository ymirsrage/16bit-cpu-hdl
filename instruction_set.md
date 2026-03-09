# Instruction Set Reference

## A-Instruction
**Format:** `0 v v v v v v v v v v v v v v v`

Loads a 15-bit value into the A-register.

**Example:**
```
@5    ->  0000000000000101   // Load 5 into A
@100  ->  0000000001100100   // Load 100 into A
```

---

## C-Instruction
**Format:** `1 1 1 a c1 c2 c3 c4 c5 c6 d1 d2 d3 j1 j2 j3`

### ALU Control (a, c1-c6)
| a | c1 | c2 | c3 | c4 | c5 | c6 | Computes |
|---|----|----|----|----|----|----|----------|
| 0 | 1  | 0  | 1  | 0  | 1  | 0  | 0        |
| 0 | 1  | 1  | 1  | 1  | 1  | 1  | 1        |
| 0 | 1  | 1  | 1  | 0  | 1  | 0  | -1       |
| 0 | 0  | 0  | 1  | 1  | 0  | 0  | D        |
| 0 | 1  | 1  | 0  | 0  | 0  | 0  | A        |
| 1 | 1  | 1  | 0  | 0  | 0  | 0  | M        |
| 0 | 0  | 0  | 1  | 1  | 1  | 1  | !D       |
| 0 | 1  | 1  | 0  | 0  | 0  | 1  | !A       |
| 0 | 0  | 0  | 1  | 1  | 1  | 0  | -D       |
| 0 | 1  | 1  | 0  | 0  | 1  | 0  | -A       |
| 0 | 0  | 1  | 1  | 1  | 1  | 1  | D+1      |
| 0 | 1  | 1  | 0  | 1  | 1  | 1  | A+1      |
| 0 | 0  | 0  | 1  | 1  | 1  | 0  | D-1      |
| 0 | 1  | 1  | 0  | 0  | 1  | 0  | A-1      |
| 0 | 0  | 0  | 0  | 0  | 1  | 0  | D+A      |
| 0 | 0  | 1  | 0  | 0  | 1  | 1  | D-A      |
| 0 | 0  | 0  | 0  | 1  | 1  | 1  | A-D      |
| 0 | 0  | 0  | 0  | 0  | 0  | 0  | D AND A  |
| 0 | 0  | 1  | 0  | 1  | 0  | 1  | D OR A   |

### Destination Bits (d1 d2 d3)
| d1 | d2 | d3 | Destination      |
|----|----|----|------------------|
| 0  | 0  | 0  | No store         |
| 0  | 0  | 1  | M (Memory[A])    |
| 0  | 1  | 0  | D register       |
| 0  | 1  | 1  | D and M          |
| 1  | 0  | 0  | A register       |
| 1  | 0  | 1  | A and M          |
| 1  | 1  | 0  | A and D          |
| 1  | 1  | 1  | A, D, and M      |

### Jump Bits (j1 j2 j3)
| j1 | j2 | j3 | Jump Condition   |
|----|----|----|------------------|
| 0  | 0  | 0  | No jump          |
| 0  | 0  | 1  | Jump if > 0      |
| 0  | 1  | 0  | Jump if = 0      |
| 0  | 1  | 1  | Jump if >= 0     |
| 1  | 0  | 0  | Jump if < 0      |
| 1  | 0  | 1  | Jump if != 0     |
| 1  | 1  | 0  | Jump if <= 0     |
| 1  | 1  | 1  | Unconditional jump|
