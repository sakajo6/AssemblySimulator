#pragma once

enum Opcode {
    Lw = 0,
    Addi,
    Lui,
    Ori,

    Sw = 4,
    Flw,
    Jalr,
    Add,

    Mul = 8,
    Jal,
    Beq,
    Fsub_s,

    Fadd_s = 12,
    Fsw,
    Fle_s,
    Fmul_s,

    Ble = 16,
    Sub,
    Feq_s,
    Fdiv_s,

    Fsqrt_s = 20,
    Div,
    Slt,
    Bge,

    Exit = 50,

    Word = 60,
};

std::map<std::string, Opcode> string_to_opcode = {
    // 0
    {"add", Add},
    {"sub", Sub},
    {"slt", Slt},
    {"mul", Mul},
    {"div", Div},

    {"fadd", Fadd_s},
    {"fsub", Fsub_s},
    {"fmul", Fmul_s},
    {"fdiv", Fdiv_s},

    {"feq", Feq_s},
    {"fle", Fle_s},
    {"flw", Flw},
    {"fsw", Fsw},
    {"fsqrt", Fsqrt_s},

    {"addi", Addi},
    {"ori", Ori},
    {"jalr", Jalr},
    {"lw", Lw},
    {"sw", Sw},

    {"beq", Beq},
    {"ble", Ble},
    {"bge", Bge},
    {"jal", Jal},
    {"lui", Lui},

    {"EXIT", Exit},

    {".word", Word}
};

std::map<Opcode, std::string> opcode_to_string = {
    {Add, "add"},
    {Sub, "sub"},
    {Slt, "slt"},
    {Mul, "mul"},
    {Div, "div"},
    
    {Fadd_s, "fadd"},
    {Fsub_s, "fsub"},
    {Fmul_s, "fmul"},
    {Fdiv_s, "fdiv"},

    {Feq_s, "feq"},
    {Fle_s, "fle"},
    {Flw, "flw"},   
    {Fsw, "fsw"},
    {Fsqrt_s, "fsqrt"},

    {Addi, "addi"},
    {Ori, "ori"},
    {Jalr, "jalr"},
    {Lw, "lw"},
    {Sw, "sw"},

    {Beq, "beq"},
    {Ble, "ble"},
    {Bge, "bge"},
    {Jal, "jal"},    
    {Lui, "lui"},
    
    {Exit, "EXIT"},

    {Word, ".word"},
};