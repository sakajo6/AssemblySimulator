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
        void check_load(int, int);
        void check_store(int, int);

    public:
        int line;
        Opcode opcode;
        bool breakpoint;
        std::string filename;

        int reg0, reg1, reg2;
        int imm;
        float fimm;

        Instruction() {}
        Instruction(int ln, Opcode opc, bool brkp, std::string curfile) {
            line = ln;
            opcode = opc;
            breakpoint = brkp;
            filename = curfile;

            reg0 = INT_MAX;
            reg1 = INT_MAX;
            reg2 = INT_MAX;
            imm = INT_MAX;
            fimm = FLT_MAX;
        }
        void print_debug(FILE *);
        int exec(FILE *, int);
};

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
    // 0 - 15
    if (opcode < 16) {
        // 0 - 7
        if (opcode < 8) {
            // 0 - 3
            if (opcode < 4) {
                // 0 - 1
                if (opcode < 2) {
                    switch(opcode) {
						case Lw: 
							{ 
								int addr = xregs[reg1] + imm;
                                #ifdef DEBUG
								Instruction::check_load(addr, pc);
                                #endif
								xregs[reg0] = memory.at(addr).i; pc+=4;
							} break;
						case Addi: xregs[reg0] = xregs[reg1] + imm; pc+=4; break;
                    }
                }
                // 2 - 3
                else {
                    switch(opcode) {
						case Lui: xregs[reg0] = (imm >> 12) << 12; pc+=4; break;
                        case Ori: xregs[reg0] = xregs[reg1] | imm; pc+=4; break;
                    }
                }
            }
            // 4 - 7
            else {
                // 4 - 5
                if (opcode < 6) {
                    switch(opcode) {
						case Sw: 
							{
								int addr = xregs[reg1] + imm;
								if (addr == -1) fprintf(fp, "%d", xregs[reg0]);
								else if (addr == -2) fprintf(fp, "%c", (char)xregs[reg0]);
								else {
                                    #ifdef DEBUG
									Instruction::check_store(addr, pc);
                                    #endif
									memory.at(addr).i = xregs[reg0];
								}
								pc+=4;
							} break;
                        case Flw: 
                            {   
                                int addr = xregs[reg1] + imm;
                                #ifdef DEBUG
								Instruction::check_load(addr, pc);
                                #endif
                                fregs[reg0] = memory.at(addr).f; 
                                pc+=4;
                            } break;
                    }
                }
                // 6 - 7
                else {
                    switch(opcode) {
                        case Jalr: xregs[reg0] = pc+4; pc = xregs[reg1] + imm; break;
						case Add: xregs[reg0] = xregs[reg1] + xregs[reg2]; pc+=4; break;
                    }
                }
            }
        }
        // 8 - 15
        else {
            // 8 - 11
            if (opcode < 12) {
                // 8 - 9
                if (opcode < 10) {
                    switch(opcode){
                        case Mul: xregs[reg0] = xregs[reg1] * xregs[reg2]; pc+=4; break;
						case Jal: xregs[reg0] = pc + 4; pc += imm; break;
                    }
                }
                // 10 - 11
                else {
                    switch(opcode) {
						case Beq: if (xregs[reg0] == xregs[reg1]) {pc += imm;} else {pc+=4;} break;
                        case Fsub: fregs[reg0] = fregs[reg1] - fregs[reg2]; pc+=4; break;
                    }
                }
            }
            // 12 - 16
            else {
                // 12 - 13
                if (opcode < 14) {                  
                    switch(opcode) { 
                        case Fadd: fregs[reg0] = fregs[reg1] + fregs[reg2]; pc+=4; break;
                        case Fsw: 
                            {   
                                int addr = xregs[reg1] + imm;
                                #ifdef DEBUG
								Instruction::check_store(addr, pc);
                                #endif
                                memory.at(addr).f = fregs[reg0];
                                pc+=4;
                            } break;
                    }
                }
                // 14 - 15
                else {
                    switch(opcode) {
                        case Fle: if (fregs[reg1] <= fregs[reg2]) { xregs[reg0] = 1;} else {xregs[reg0] = 0;}; pc+=4; break;
                        case Fmul: fregs[reg0] = fregs[reg1] * fregs[reg2]; pc+=4; break;
                    }
                }
            }
        }
    }
    else if (opcode < 50) {
        // 16 - 19
        if (opcode < 20) {
            // 16 - 17
            if (opcode < 18) {
                switch(opcode) {
                    case Ble: if (xregs[reg0] <= xregs[reg1]) { pc += imm; } else {pc+=4;} break;
                    case Sub: xregs[reg0] = xregs[reg1] - xregs[reg2]; pc+=4; break;
                }
            }
            // 18 - 19
            else {
                switch(opcode) {
                    case Feq: if (fregs[reg1] == fregs[reg2]) {xregs[reg0] = 1;} else {xregs[reg0] = 0;}; pc+=4; break;
                    case Fdiv: fregs[reg0] = fregs[reg1] / fregs[reg2]; pc+=4; break;
                }
            }
        }
        // 20 - 23
        else {
            // 20 - 21
            if (opcode < 22) {
                switch(opcode) {
                    case Fsqrt: fregs[reg0] = sqrt(fregs[reg1]); pc+=4; break;
                    case Div: xregs[reg0] = xregs[reg1] / xregs[reg2]; pc+=4; break;
                }
            }
            // 22 - 23
            else {
                switch(opcode) {
                    case Slt: if (xregs[reg1] < xregs[reg2]) {xregs[reg0] = 1;} else {xregs[reg0] = 0;}; pc+=4; break;
                    case Bge: if (xregs[reg0] >= xregs[reg1]) {pc += imm;} else {pc+=4;} break;
                }
            }
        } 
    }
    else if (opcode < 60) {
        std::cerr << "this is end-point" << std::endl;
        exit(1);
    }
    else {
        std::cerr << "this is data section" << std::endl;
        exit(1);
    }

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