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
    Fsub,

    Fadd = 12,
    Fsw,
    Fle,
    Fmul,

    Ble = 16,
    Sub,
    Feq,
    Fdiv,

    Fsqrt = 20,
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

    {"fadd", Fadd},
    {"fsub", Fsub},
    {"fmul", Fmul},
    {"fdiv", Fdiv},

    {"feq", Feq},
    {"fle", Fle},
    {"flw", Flw},
    {"fsw", Fsw},
    {"fsqrt", Fsqrt},

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
    
    {Fadd, "fadd"},
    {Fsub, "fsub"},
    {Fmul, "fmul"},
    {Fdiv, "fdiv"},

    {Feq, "feq"},
    {Fle, "fle"},
    {Flw, "flw"},   
    {Fsw, "fsw"},
    {Fsqrt, "fsqrt"},

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
