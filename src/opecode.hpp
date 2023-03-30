#pragma once

enum Opcode {
    Add,
    Sub,
    Slt,
    Mul,
    Div,

    Fadd,
    Fsub,
    Fmul,
    Fdiv,

    Feq,
    Fle,
    Flw,
    Fsw,
    Fsqrt,

    Addi,
    Ori,
    Jalr,
    Lw,
    Sw,

    Beq,
    Ble,
    Bge,
    Jal,
    Lui,

    Exit,
    
    Word,
    
    Arrlw ,
    Arrsw,
    Arrflw,
    Arrfsw,
};

std::map<std::string, Opcode> string_to_opcode = {
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

    {".word", Word},

    {"arrlw", Arrlw},
    {"arrsw", Arrsw},
    {"arrflw", Arrflw},
    {"arrfsw", Arrfsw},
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

    {Arrlw, "arrlw"},
    {Arrsw, "arrsw"},
    {Arrflw, "arrflw"},
    {Arrfsw, "arrfsw"},
};
