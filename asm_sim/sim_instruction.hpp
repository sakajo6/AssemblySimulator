#pragma once

#include <vector>
#include <math.h>

#include "sim_opecode.hpp"
#include "sim_global.hpp"


extern const int memory_size;
extern int memory[memory_size];
extern const int xregs_size;
extern int xregs[xregs_size];
extern const int fregs_size;
extern float fregs[fregs_size];

class Instruction {
    private: 
        Opcode opcode;
        int oprand0, oprand1, oprand2;
        int label;
        int imm;

    public:
        Instruction() {}
        Instruction(Opcode opc, int opr0, int opr1, int opr2, int lab, int im) {
            opcode = opc;
            oprand0 = opr0;
            oprand1 = opr1;
            oprand2 = opr2;
            label = lab;
            imm = im;
        }
        void print_debug();
        int exec(int pc);
};

inline void Instruction::print_debug() {
    std::cout << opcode << " "
    << oprand0 << " "
    << oprand1 << " "
    << oprand2 << " "
    << label << " "
    << imm << std::endl;
}

inline int Instruction::exec(int pc) {
    switch(opcode) {
        // pattern 0
        case Add: xregs[oprand0] = xregs[oprand1] + xregs[oprand2]; pc+=4; break;
        case Sub: xregs[oprand0] = xregs[oprand1] - xregs[oprand2]; pc+=4; break;
        case Slt: if (xregs[oprand1] < xregs[oprand2]) {xregs[oprand0] = 1;} else {xregs[oprand0] = 0;}; pc+=4; break;

        case Mul: xregs[oprand0] = xregs[oprand1] * xregs[oprand2]; pc+=4; break;
        case Div: xregs[oprand0] = xregs[oprand1] / xregs[oprand2]; pc+=4; break;
        
        case Fadd_s: fregs[oprand0] = fregs[oprand1] + fregs[oprand2]; pc+=4; break;
        case Fsub_s: fregs[oprand0] = fregs[oprand1] - fregs[oprand2]; pc+=4; break;
        case Fmul_s: fregs[oprand0] = fregs[oprand1] * fregs[oprand2]; pc+=4; break;
        case Fdiv_s: fregs[oprand0] = fregs[oprand1] / fregs[oprand2]; pc+=4; break;
        case Feq_s: if (fregs[oprand1] == fregs[oprand2]) {fregs[oprand0] = 1;} else {fregs[oprand0] = 0;}; pc+=4; break;
        case Flt_s: if (fregs[oprand1] < fregs[oprand2]) {fregs[oprand0] = 1;} else {fregs[oprand0] = 0;}; pc+=4; break;

        // pattern 1
        case Addi: xregs[oprand0] = xregs[oprand1] + imm; pc+=4; break;
        
        // pattern 2
        case Lw: xregs[oprand0] = memory[xregs[oprand1] + imm]; pc+=4; break;
        case Sw: memory[xregs[oprand1] + imm] = xregs[oprand0]; pc+=4; break;
        case Jalr: xregs[oprand0] = pc+4; pc = xregs[oprand1] + imm; break;
        case Flw: fregs[oprand0] = memory[xregs[oprand1] + imm]; pc+=4; break;
        case Fsw: memory[xregs[oprand1] + imm] = fregs[oprand0]; pc+=4; break;

        // pattern 3
        case Beq: if (xregs[oprand0] == xregs[oprand1]) {pc += label;} else {pc+=4;} break;
        case Blt: if (xregs[oprand0] < xregs[oprand1]) { pc += label; } else {pc+=4;} break;
        case Bge: if (xregs[oprand0] >= xregs[oprand1]) {pc += label;} else {pc+=4;} break;

        // pattern 4
        case Jal: xregs[oprand0] = pc + 4; pc += label; break;

        // pattern 5
        case Fsqrt_s: fregs[oprand0] = sqrt(fregs[oprand1]); pc+=4; break;

        default: 
            std::cerr << "instruction-execution error" << std::endl;
            exit(1);
    }

    return pc;
}
