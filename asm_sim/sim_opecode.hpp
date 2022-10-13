#pragma once

enum Opcode {
    // 0 -> opcode r, r, r
    Add,
    Sub,
    Slt,

    Mul,
    Div,

    Fadd_d,
    Fsub_d,
    Fmul_d,
    Fdiv_d,
    Feq_d,
    Flt_d,


    // 1 -> opcode r, r, imm
    Addi,

    // 2 -> opcode r, imm(r)
    Lw,
    Sw,
    Jalr,
    Fld,
    Fsd,

    // 3 -> opcode r, r, label
    Beq,
    Blt,
    Bge,

    // 4 -> opcode r, label
    Jal,

    // 5 -> opcode r, r
    Fsqrt_d,

};