#pragma once

enum Opcode {
    Add = 0,
    Sub,
    Slt,
    Mul,

    Div = 4,
    Fadd_s,
    Fsub_s,
    Fmul_s,

    Fdiv_s = 8,
    Feq_s,
    Fle_s,
    Flw,

    Fsw = 12,
    Fsqrt_s,
    Addi,
    Ori,

    Jalr = 16,
    Lw,
    Sw,
    Beq,

    Ble = 20,
    Bge,
    Jal,
    Lui,

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