#pragma once

enum Opcode {
    // 0 -> opcode r, r, r
    Add = 0,
    Sub,
    Slt,

    Mul,
    Div,

    Fadd_s,
    Fsub_s,
    Fmul_s,
    Fdiv_s,
    Feq_s,
    Flt_s,


    // 1 -> opcode r, r, imm
    Addi = 100,
    Ori,

    // 2 -> opcode r, imm(r)
    Lw = 200,
    Sw,
    Flw,
    Fsw,

    // 3 -> opcode r, r, label
    Beq = 300,
    Blt,
    Bge,
    Jalr,

    // 4 -> opcode r, label
    Jal = 400,

    // 5 -> opcode r, r
    Fsqrt_s = 500,

    // 6 -> opcode, r, imm
    Lui = 600,
};