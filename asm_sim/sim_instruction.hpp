#pragma once

#include <vector>

#include "fib_opecode.hpp"



class Instruction {
    private: 
        Opcode opcode;
        int oprand0, oprand1, oprand2;
        int label;
        int imm;

    public:
        Instruction(Opcode opc, int opr0, int opr1, int opr2, int lab, int im) {
            opcode = opc;
            oprand0 = opr0;
            oprand1 = opr1;
            oprand2 = opr2;
            label = lab;
            imm = im;
        }
        void print_debug();
        int exec(int pc, std::vector<int> &labels_address, int *memory, int *regis);
};

inline void Instruction::print_debug() {
    std::cout << opcode << " "
    << oprand0 << " "
    << oprand1 << " "
    << oprand2 << " "
    << label << " "
    << imm << std::endl;
}

inline int Instruction::exec(int pc, std::vector<int> &labels_address, int *memory, int *regis) {
    switch(opcode) {
        // pattern 0
        case Add: 
            regis[oprand0] = regis[oprand1] + regis[oprand2]; 
            pc++;
            break;
        case Sub:
            regis[oprand0] = regis[oprand1] - regis[oprand2];
            pc++;
            break;
        case Slt:
            break;

        // pattern 1
        case Addi: 
            regis[oprand0] = regis[oprand1] + imm;
            pc++;
            break;
        
        // pattern 2
        case Lw: 
            regis[oprand0] = memory[regis[oprand1] + imm];
            pc++;
            break;
        case Sw: 
            memory[regis[oprand1] + imm] = regis[oprand0];
            pc++;
            break;
        case Jalr:
            break;

        // pattern 3
        case Beq: 
            break;
        case Blt:
            if (regis[oprand0] < regis[oprand1]) {
                pc = labels_address[label];
            }
            else {
                pc++;
            }
            break;
        case Bge:
            break;

        // pattern 4
        case Jal:
            pc = regis[oprand0] + labels_address[label];
            break;
    }

    return pc;
}
