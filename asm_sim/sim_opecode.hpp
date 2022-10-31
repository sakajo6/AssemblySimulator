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
    Jalr,

    // 2 -> opcode r, imm(r)
    Lw = 200,
    Sw,
    Flw,
    Fsw,

    // 3 -> opcode r, r, label
    Beq = 300,
    Ble,
    Bge,

    // 4 -> opcode r, label
    Jal = 400,

    // 5 -> opcode r, r
    Fsqrt_s = 500,

    // 6 -> opcode, r, imm
    Lui = 600,
};

std::map<std::string, Opcode> string_to_opcode = {
    // 0
    {"add", Add},
    {"sub", Sub},
    {"slt", Slt},

    {"mul", Mul},
    {"div", Div},

    {"fadd.s", Fadd_s},
    {"fsub.s", Fsub_s},
    {"fmul.s", Fmul_s},
    {"fdiv.s", Fdiv_s},
    {"feq.s", Feq_s},
    {"flt.s", Flt_s},

    // 1
    {"addi", Addi},
    {"ori", Ori},
    {"jalr", Jalr},

    // 2
    {"lw", Lw},
    {"sw", Sw},
    {"flw", Flw},
    {"fsw", Fsw},

    // 3
    {"beq", Beq},
    {"ble", Ble},
    {"bge", Bge},

    // 4
    {"jal", Jal},

    // 5
    {"fsqrt.s", Fsqrt_s},

    // 6
    {"lui", Lui},
};

std::map<Opcode, std::string> opcode_to_string = {
    {Add, "add"},
    {Sub, "sub"},
    {Slt, "slt"},

    {Mul, "mul"},
    {Div, "div"},
    
    {Fadd_s, "fadd.s"},
    {Fsub_s, "fsub.s"},
    {Fmul_s, "fmul.s"},
    {Fdiv_s, "fdiv.s"},
    {Feq_s, "feq.s"},
    {Flt_s, "flt.s"},

    {Addi, "addi"},
    {Ori, "ori"},
    {Jalr, "jalr"},

    {Lw, "lw"},
    {Sw, "sw"},
    {Flw, "flw"},   
    {Fsw, "fsw"},

    {Beq, "beq"},
    {Ble, "ble"},
    {Bge, "bge"},

    {Jal, "jal"},
    
    {Fsqrt_s, "fsqrt.s"},
    
    {Lui, "lui"},
};