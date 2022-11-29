#pragma once

#include <vector>
#include <string>
#include <math.h>
#include <bitset>
#include <stdlib.h>
#include <iostream>
#include <cfloat>
#include <climits>
#include <assert.h>

#include "sim_opecode.hpp"
#include "sim_global.hpp"
#include "sim_machinecode.hpp"

class Instruction {
    private: 
        int line;
        bool breakpoint;
        std::string filename;

        int (Instruction::*func)(FILE *, int);

        void check_load(int, int);
        void check_store(int, int);

        int Addfun(FILE *, int);
        int Subfun(FILE *, int);
        int Sltfun(FILE *, int);
        int Mulfun(FILE *, int);
        int Divfun(FILE *, int);
        int Faddfun(FILE *, int);
        int Fsubfun(FILE *, int);
        int Fmulfun(FILE *, int);
        int Fdivfun(FILE *, int);
        int Feqfun(FILE *, int);
        int Flefun(FILE *, int);
        int Flwfun(FILE *, int);
        int Fswfun(FILE *, int);
        int Fsqrtfun(FILE *, int);
        int Addifun(FILE *, int);
        int Orifun(FILE *, int);
        int Jalrfun(FILE *, int);
        int Lwfun(FILE *, int);
        int Swfun(FILE *, int);
        int Beqfun(FILE *, int);
        int Blefun(FILE *, int);
        int Bgefun(FILE *, int);
        int Jalfun(FILE *, int);
        int Luifun(FILE *, int);
        int Exitfun(FILE *, int);
        int Wordfun(FILE *, int);

    public:
        Opcode opcode;
        int reg0, reg1, reg2, imm;
        float fimm;

        Instruction() {}
        Instruction(int ln, Opcode opc, bool brkp, std::string curfile) {
            line = ln;
            opcode = opc;
            breakpoint = brkp;
            filename = curfile;

            switch(opcode) {
                case Add: func = &Instruction::Addfun; break;
                case Sub: func = &Instruction::Subfun; break;
                case Slt: func = &Instruction::Sltfun; break;
                case Mul: func = &Instruction::Mulfun; break;
                case Div: func = &Instruction::Divfun; break;
                case Fadd: func = &Instruction::Faddfun; break;
                case Fsub: func = &Instruction::Fsubfun; break;
                case Fmul: func = &Instruction::Fmulfun; break;
                case Fdiv: func = &Instruction::Fdivfun; break;
                case Feq: func = &Instruction::Feqfun; break;
                case Fle: func = &Instruction::Flefun; break;
                case Flw: func = &Instruction::Flwfun; break;
                case Fsw: func = &Instruction::Fswfun; break;
                case Fsqrt: func = &Instruction::Fsqrtfun; break;
                case Addi: func = &Instruction::Addifun; break;
                case Ori: func = &Instruction::Orifun; break;
                case Jalr: func = &Instruction::Jalrfun; break;
                case Lw: func = &Instruction::Lwfun; break;
                case Sw: func = &Instruction::Swfun; break;
                case Beq: func = &Instruction::Beqfun; break;
                case Ble: func = &Instruction::Blefun; break;
                case Bge: func = &Instruction::Bgefun; break;
                case Jal: func = &Instruction::Jalfun; break;
                case Lui: func = &Instruction::Luifun; break;
                case Exit: func = &Instruction::Exitfun; break;
                case Word: func = &Instruction::Wordfun; break;
                default: std::cerr << "error: Instruction constructor error" << std::endl; exit(1);
            }

            reg0 = INT_MAX;
            reg1 = INT_MAX;
            reg2 = INT_MAX;
            imm = INT_MAX;
            fimm = FLT_MAX;
        }
        void print_debug(FILE *);
        int exec(FILE *, int);
};

inline int Instruction::Addfun(FILE *fp, int pc) {
    xregs[reg0] = xregs[reg1] + xregs[reg2]; pc+=4; return pc;
}
inline int Instruction::Subfun(FILE *fp, int pc) {
    xregs[reg0] = xregs[reg1] - xregs[reg2]; pc+=4; return pc;
}
inline int Instruction::Sltfun(FILE *fp, int pc) {
    if (xregs[reg1] < xregs[reg2]) {xregs[reg0] = 1;} else {xregs[reg0] = 0;}; pc+=4; return pc;
}
inline int Instruction::Mulfun(FILE *fp, int pc) {
    xregs[reg0] = xregs[reg1] * xregs[reg2]; pc+=4; return pc;
}
inline int Instruction::Divfun(FILE *fp, int pc) {
    xregs[reg0] = xregs[reg1] / xregs[reg2]; pc+=4; return pc;
}
inline int Instruction::Faddfun(FILE *fp, int pc) {
    fregs[reg0] = fregs[reg1] + fregs[reg2]; pc+=4; return pc;
}
inline int Instruction::Fsubfun(FILE *fp, int pc) {
    fregs[reg0] = fregs[reg1] - fregs[reg2]; pc+=4; return pc;
}
inline int Instruction::Fmulfun(FILE *fp, int pc) {
    fregs[reg0] = fregs[reg1] * fregs[reg2]; pc+=4; return pc;
}
inline int Instruction::Fdivfun(FILE *fp, int pc) {
    fregs[reg0] = fregs[reg1] / fregs[reg2]; pc+=4; return pc;
}
inline int Instruction::Feqfun(FILE *fp, int pc) {
    if (fregs[reg1] == fregs[reg2]) {xregs[reg0] = 1;} else {xregs[reg0] = 0;}; pc+=4; return pc;
}
inline int Instruction::Flefun(FILE *fp, int pc) {
    if (fregs[reg1] <= fregs[reg2]) { xregs[reg0] = 1;} else {xregs[reg0] = 0;}; pc+=4; return pc;
}
inline int Instruction::Flwfun(FILE *fp, int pc) {
    int addr = xregs[reg1] + imm;
    #ifdef DEBUG
    Instruction::check_load(addr, pc);
    #endif
    fregs[reg0] = memory.at(addr).f; pc+=4; return pc;
}
inline int Instruction::Fswfun(FILE *fp, int pc) {
    int addr = xregs[reg1] + imm; 
    #ifdef DEBUG
    Instruction::check_store(addr, pc);
    #endif
    memory.at(addr).f = fregs[reg0]; pc+=4; return pc;
}
inline int Instruction::Fsqrtfun(FILE *fp, int pc) {
    fregs[reg0] = sqrt(fregs[reg1]); pc+=4; return pc;
}
inline int Instruction::Addifun(FILE *fp, int pc) {
    xregs[reg0] = xregs[reg1] + imm; pc+=4; return pc;
}
inline int Instruction::Orifun(FILE *fp, int pc) {
    xregs[reg0] = xregs[reg1] | imm; pc+=4; return pc;
}
inline int Instruction::Jalrfun(FILE *fp, int pc) {
    xregs[reg0] = pc+4; pc = xregs[reg1] + imm; return pc;
}
inline int Instruction::Lwfun(FILE *fp, int pc) {
	int addr = xregs[reg1] + imm;
    #ifdef DEBUG
    Instruction::check_load(addr, pc);
    #endif
    xregs[reg0] = memory.at(addr).i; pc+=4; return pc;
}
inline int Instruction::Swfun(FILE *fp, int pc) {
    int addr = xregs[reg1] + imm;
    if (addr == -1) fprintf(fp, "%d", xregs[reg0]);
	else if (addr == -2) fprintf(fp, "%c", (char)xregs[reg0]);
	else {
        #ifdef DEBUG
        Instruction::check_store(addr, pc);
        #endif
		memory.at(addr).i = xregs[reg0];
	}
	pc+=4; return pc;
}
inline int Instruction::Beqfun(FILE *fp, int pc) {
    if (xregs[reg0] == xregs[reg1]) {pc += imm;} else {pc+=4;} return pc;
}
inline int Instruction::Blefun(FILE *fp, int pc) {
    if (xregs[reg0] <= xregs[reg1]) { pc += imm; } else {pc+=4;} return pc;
}
inline int Instruction::Bgefun(FILE *fp, int pc) {
    if (xregs[reg0] >= xregs[reg1]) {pc += imm;} else {pc+=4;} return pc;
}
inline int Instruction::Jalfun(FILE *fp, int pc) {
    xregs[reg0] = pc + 4; pc += imm; return pc;
}
inline int Instruction::Luifun(FILE *fp, int pc) {
    xregs[reg0] = (imm >> 12) << 12; pc+=4; return pc;
}
inline int Instruction::Exitfun(FILE *fp, int pc) {
    std::cerr << "this is end-point" << std::endl;
    exit(1); return -1;
}
inline int Instruction::Wordfun(FILE *fp, int pc) {
    std::cerr << "this is data section" << std::endl;
    exit(1); return -1;
}

inline void Instruction::print_debug(FILE *fp) {
    fprintf(fp, "%s ", opcode_to_string[opcode].c_str());
    if (reg0 != INT_MAX) fprintf(fp, "a%d ", reg0);
    if (reg1 != INT_MAX) fprintf(fp, "a%d ", reg1);
    if (reg2 != INT_MAX) fprintf(fp, "a%d ", reg2);
    if (imm != INT_MAX) fprintf(fp, "%d ", imm);
    if (fimm != FLT_MAX) fprintf(fp, "%f", fimm);
}

inline void Instruction::check_load(int addr, int pc) {
    if (addr <= 0 || addr >= memory_size) {
        std::cout << "\t" << filename << ", line " << line << std::endl;
        std::cout << "\t";
        Instruction::print_debug(stdout);
        std::cout << "\n\n";
        globalfun::print_regs(binflag);
        if (addr == 0) std::cerr <<  "error: memory outof range or accessing text/data section. pc = " << pc << std::endl;
        else std::cerr << "error: this is entry-point. pc = " << pc << std::endl;
        exit(1);
    }
}

inline void Instruction::check_store(int addr, int pc) {
    if (addr < text_data_section || addr >= memory_size) {
        std::cout << "\t" << filename << ", line " << line << std::endl;
        std::cout << "\t";
        Instruction::print_debug(stdout);
        std::cout << "\n\n";
        globalfun::print_regs(binflag);
        std::cerr << "error: memory outof range or accessing text/data section. pc = " << pc << std::endl;
        exit(1);
    }    
}

inline int Instruction::exec(FILE *fp, int pc) {
    pc = (this->*func)(fp, pc);
    xregs[0] = 0;

    #ifdef DEBUG
    if ((breakpoint || brkallflag) && !brknonflag) {
        std::cout << "\t" << filename << ", line " << line << std::endl;
        std::cout << "\t";
        Instruction::print_debug(stdout);
        std::cout << "\n\n";
        globalfun::print_regs(binflag);
        std::cout << "\n\tcurrent pc = " << pc << std::endl;
        std::cout << "\n<<< PRESS ENTER" << std::endl;

        getchar();
    }
    // check next pc
    check_load(pc, pc);
    #endif

    return pc;
}