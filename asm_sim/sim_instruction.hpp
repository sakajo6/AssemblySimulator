#pragma once

#include <vector>
#include <math.h>
#include <bitset>

#include "sim_opecode.hpp"
#include "sim_global.hpp"
#include "sim_machinecode.hpp"


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

        void set_machine_code(char *mcode, int lidx, int ridx, int imm);

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
        void assemble(FILE *fp);
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
        // op ope0, ope1, op2
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
        // op ope0, ope1, imm
        case Addi: xregs[oprand0] = xregs[oprand1] + imm; pc+=4; break;
        case Ori: xregs[oprand0] = xregs[oprand1] | imm; pc+=4; break;
        
        // pattern 2
        // op ope0, imm(op1)
        case Lw: xregs[oprand0] = memory[xregs[oprand1] + imm]; pc+=4; break;
        case Sw: memory[xregs[oprand1] + imm] = xregs[oprand0]; pc+=4; break;
        case Jalr: xregs[oprand0] = pc+4; pc = xregs[oprand1] + imm; break;
        case Flw: fregs[oprand0] = memory[xregs[oprand1] + imm]; pc+=4; break;
        case Fsw: memory[xregs[oprand1] + imm] = fregs[oprand0]; pc+=4; break;

        // pattern 3
        // op ope0, ope1, label
        case Beq: if (xregs[oprand0] == xregs[oprand1]) {pc += label;} else {pc+=4;} break;
        case Blt: if (xregs[oprand0] < xregs[oprand1]) { pc += label; } else {pc+=4;} break;
        case Bge: if (xregs[oprand0] >= xregs[oprand1]) {pc += label;} else {pc+=4;} break;

        // pattern 4
        // op ope0, label
        case Jal: xregs[oprand0] = pc + 4; pc += label; break;

        // pattern 5
        // op ope0, ope1
        case Fsqrt_s: fregs[oprand0] = sqrt(fregs[oprand1]); pc+=4; break;

        // pattern 6
        // op ope0, imm
        case Lui: xregs[oprand0] = imm << 12; pc+=4; break;

        default: 
            std::cerr << "instruction-execution error" << std::endl;
            exit(1);
    }

    return pc;
}

inline void Instruction::set_machine_code(char *mcode, int lidx, int ridx, int imm){
    // [lidx, ridx]
    unsigned int uimm = (unsigned int)imm;
    for (int i = ridx; i >= lidx; i--) {
        mcode[i] = '0' + uimm%2;
        uimm >>= 2;
    }
}

inline void Instruction::assemble(FILE *fp) {
    switch(opcode) {
        // pattern 0
        // op ope0, ope1, op2
        case Add: 
            Instruction::set_machine_code(add_machine, 7, 11, oprand2);
            Instruction::set_machine_code(add_machine, 12, 16, oprand1);
            Instruction::set_machine_code(add_machine, 20, 24, oprand0);
            fwrite(add_machine, sizeof(char), 33, fp);
            break;
        case Sub: break;
        case Slt: break;

        case Mul: break;
        case Div: break;
        
        case Fadd_s: break;
        case Fsub_s: break;
        case Fmul_s: break;
        case Fdiv_s: break;
        case Feq_s: break;
        case Flt_s: break;

        // pattern 1
        case Addi:
            Instruction::set_machine_code(addi_machine, 0, 11, imm);
            Instruction::set_machine_code(addi_machine, 12, 16, oprand1);
            Instruction::set_machine_code(addi_machine, 20, 24, oprand0);
            fwrite(addi_machine, sizeof(char), 33, fp);
            break;
        case Ori: break;
        
        // pattern 2
        case Lw:             
            Instruction::set_machine_code(lw_machine, 0, 11, imm);
            Instruction::set_machine_code(lw_machine, 12, 16, oprand1);
            Instruction::set_machine_code(lw_machine, 20, 24, oprand0);
            fwrite(lw_machine, sizeof(char), 33, fp);
            break;
        case Sw:
            Instruction::set_machine_code(sw_machine, 0, 6, imm >> 5);
            Instruction::set_machine_code(sw_machine, 7, 11, oprand0);
            Instruction::set_machine_code(sw_machine, 12, 16, oprand1);
            Instruction::set_machine_code(sw_machine, 20, 24, imm);
            fwrite(sw_machine, sizeof(char), 33, fp);
            break;
        case Jalr: break;
        case Flw: break;
        case Fsw: break;

        // pattern 3
        case Beq: break;
        case Blt:
            Instruction::set_machine_code(blt_machine, 0, 6, imm >> 6);
            Instruction::set_machine_code(blt_machine, 7, 11, oprand1);
            Instruction::set_machine_code(blt_machine, 12, 16, oprand0);
            Instruction::set_machine_code(blt_machine, 20, 24, imm >> 1);
            fwrite(blt_machine, sizeof(char), 33, fp);    
        case Bge: break;

        // pattern 4
        case Jal:
            Instruction::set_machine_code(jal_machine, 0, 19, label >> 1);
            Instruction::set_machine_code(jal_machine, 20, 24, oprand0);
            fwrite(jal_machine, sizeof(char), 33, fp); 
        // pattern 5
        case Fsqrt_s: break;

        // pattern 6
        case Lui: break;

        default: 
            std::cerr << "instruction-execution error" << std::endl;
            exit(1);
    }

}
