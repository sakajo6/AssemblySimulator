#pragma once

#include <vector>

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
        int exec(int pc, std::vector<int> &labels_address);
};

inline void Instruction::print_debug() {
    std::cout << opcode << " "
    << oprand0 << " "
    << oprand1 << " "
    << oprand2 << " "
    << label << " "
    << imm << std::endl;
}

inline int Instruction::exec(int pc, std::vector<int> &labels_address) {
    switch(opcode) {
        // pattern 0
        case Add: xregs[oprand0] = xregs[oprand1] + xregs[oprand2]; pc++; break;
        case Sub: xregs[oprand0] = xregs[oprand1] - xregs[oprand2]; pc++; break;
        case Slt: break;

        case Mul: xregs[oprand0] = xregs[oprand1] * xregs[oprand2]; pc++; break;
        case Div: xregs[oprand0] = xregs[oprand1] / xregs[oprand2]; pc++; break;
        
        case Fadd_s: fregs[oprand0] = fregs[oprand1] + fregs[oprand2]; pc++; break;
        case Fsub_s: fregs[oprand0] = fregs[oprand1] - fregs[oprand2]; pc++; break;
        case Fmul_s: fregs[oprand0] = fregs[oprand1] * fregs[oprand2]; pc++; break;
        case Fdiv_s: fregs[oprand0] = fregs[oprand1] / fregs[oprand2]; pc++; break;
        case Feq_s: break;
        case Flt_s: break;

        // pattern 1
        case Addi: xregs[oprand0] = xregs[oprand1] + imm; pc++; break;
        
        // pattern 2
        case Lw: xregs[oprand0] = memory[xregs[oprand1] + imm]; pc++; break;
        case Sw: memory[xregs[oprand1] + imm] = xregs[oprand0]; pc++; break;
        case Jalr: break;
        case Flw: break;
        case Fsw: break;

        // pattern 3
        case Beq: break;
        case Blt: if (xregs[oprand0] < xregs[oprand1]) { pc = labels_address[label]; } else { pc++; } break;
        case Bge: break;

        // pattern 4
        case Jal: pc = xregs[oprand0] + labels_address[label]; break;

        // pattern 5
        case Fsqrt_s: break;
    }

    return pc;
}
