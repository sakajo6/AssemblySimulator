#pragma once

enum Opcode {
    // 0
    Add,    // 0
    Sub,    // 1
    Slt,    // 2

    // 1
    Addi,   // 3

    // 2
    Lw,     // 4
    Sw,     // 5
    Jalr,   // 6

    // 3
    Beq,    // 7
    Blt,    // 8
    Bge,    // 9

    // 4
    Jal,    // 10
};

/*
    0 -> opcode r, r, r
        add, sub, slt, 
    1 -> opcode r, r, imm
        addi, 
    2 -> opcode r, imm(r)
        lw, sw, jalr
    3 -> opcode r, r, label
        beq, blt, bge
    4 -> opcode r, label
        jal
*/