#pragma once

#include <vector>
#include <string>
#include <math.h>
#include <bitset>
#include <stdlib.h>
#include <iostream>

#include "sim_opecode.hpp"
#include "sim_global.hpp"
#include "sim_machinecode.hpp"

class Instruction {
    private: 
        void set_machine_R(std::bitset<32> *);
        void set_machine_I(std::bitset<32> *);
        void set_machine_S(std::bitset<32> *);
        void set_machine_B(std::bitset<32> *);
        void set_machine_U(std::bitset<32> *);
        void set_machine_J(std::bitset<32> *);

    public:
        int line;
        Opcode opcode;
        bool breakpoint;
        std::string filename;

        int reg0, reg1, reg2;
        int imm;

        Instruction() {}
        Instruction(int ln, Opcode opc, bool brkp, std::string curfile) {
            line = ln;
            opcode = opc;
            breakpoint = brkp;
            filename = curfile;

            reg0 = -1;
            reg1 = -1;
            reg2 = -1;
            imm = -1;
        }
        void print_debug(FILE *);
        int exec(FILE *, int, bool, bool);
        void assemble(FILE *, int);
};

inline void Instruction::print_debug(FILE *fp) {
    fprintf(fp, "%s ", opcode_to_string[opcode].c_str());
    if (reg0 != -1) fprintf(fp, "a%d ", reg0);
    if (reg1 != -1) fprintf(fp, "a%d ", reg1);
    if (reg2 != -1) fprintf(fp, "a%d ", reg2);
    if (imm != -1) fprintf(fp, "%d ", imm);
}



inline int Instruction::exec(FILE *fp, int pc, bool binflag, bool brkallflag) {
    if (opcode < 10) {
        if (opcode < 2) {
            switch(opcode) {
                case Add: xregs[reg0] = xregs[reg1] + xregs[reg2]; pc+=4; break;
                case Sub: xregs[reg0] = xregs[reg1] - xregs[reg2]; pc+=4; break;
                default: 
                    std::cerr << "error occurred: line " << line << std::endl;
                    std::cerr << "current pc = " << pc << std::endl;
                    std::cerr << "instruction-execution error" << std::endl;
                    exit(1);
            }  
        }
        else {
            switch(opcode) {
                case Slt: if (xregs[reg1] < xregs[reg2]) {xregs[reg0] = 1;} else {xregs[reg0] = 0;}; pc+=4; break;
                case Mul: xregs[reg0] = xregs[reg1] * xregs[reg2]; pc+=4; break;
                case Div: xregs[reg0] = xregs[reg1] / xregs[reg2]; pc+=4; break;
                default: 
                    std::cerr << "error occurred: line " << line << std::endl;
                    std::cerr << "current pc = " << pc << std::endl;
                    std::cerr << "instruction-execution error" << std::endl;
                    exit(1);
            }  
        } 
    }
    else if (opcode < 20) {
        if (opcode < 12) {
            switch(opcode) {
                case Fadd_s: fregs[reg0] = fregs[reg1] + fregs[reg2]; pc+=4; break;
                case Fsub_s: fregs[reg0] = fregs[reg1] - fregs[reg2]; pc+=4; break;
                default: 
                    std::cerr << "error occurred: line " << line << std::endl;
                    std::cerr << "current pc = " << pc << std::endl;
                    std::cerr << "instruction-execution error" << std::endl;
                    exit(1);
            }
        }
        else {
            switch(opcode) {
                case Fmul_s: fregs[reg0] = fregs[reg1] * fregs[reg2]; pc+=4; break;
                case Fdiv_s: fregs[reg0] = fregs[reg1] / fregs[reg2]; pc+=4; break;
                default: 
                    std::cerr << "error occurred: line " << line << std::endl;
                    std::cerr << "current pc = " << pc << std::endl;
                    std::cerr << "instruction-execution error" << std::endl;
                    exit(1);
            }
        }

    }
    else if (opcode < 30) {
        if (opcode < 22) {
            switch(opcode) {          
                case Feq_s: if (fregs[reg1] == fregs[reg2]) {fregs[reg0] = 1;} else {fregs[reg0] = 0;}; pc+=4; break;
                case Fle_s: if (fregs[reg1] <= fregs[reg2]) {fregs[reg0] = 1;} else {fregs[reg0] = 0;}; pc+=4; break;
                default: 
                    std::cerr << "error occurred: line " << line << std::endl;
                    std::cerr << "current pc = " << pc << std::endl;
                    std::cerr << "instruction-execution error" << std::endl;
                    exit(1);
            }
        }
        else {
            switch(opcode) {          
                case Flw: 
                    {union {float f; int i; } ftemp;
                    int addr = (xregs[reg1] + imm)/4;
                    if (addr < 0 || addr >= memory_size) {
                        std::cerr << "error: memory outof range. pc = " << pc << std::endl;
                        exit(1);
                    }
                    ftemp.i = memory.at(addr);
                    fregs[reg0] = ftemp.f; pc+=4;} break;
                case Fsw: 
                    {union {float f; int i; } ftemp;
                    ftemp.f = fregs[reg0];
                    int addr = xregs[reg1] + imm;
                    if (addr != -1) {
                        if (addr/4 < -1 || addr/4 >= memory_size) {
                            std::cerr << "error: memory outof range. pc = " << pc << std::endl;
                            exit(1);
                        }
                        memory.at(addr/4) = ftemp.i;
                    }
                    else fprintf(fp, "%f\n", ftemp.f);
                    pc+=4;} break;
                case Fsqrt_s: fregs[reg0] = sqrt(fregs[reg1]); pc+=4; break;
                default: 
                    std::cerr << "error occurred: line " << line << std::endl;
                    std::cerr << "current pc = " << pc << std::endl;
                    std::cerr << "instruction-execution error" << std::endl;
                    exit(1);
            }
        }
    }
    else if (opcode < 40) {
        if (opcode < 32) {
            switch(opcode) {
                case Addi: xregs[reg0] = xregs[reg1] + imm; pc+=4; break;
                case Ori: xregs[reg0] = xregs[reg1] | imm; pc+=4; break;
                default: 
                    std::cerr << "error occurred: line " << line << std::endl;
                    std::cerr << "current pc = " << pc << std::endl;
                    std::cerr << "instruction-execution error" << std::endl;
                    exit(1);
            }
        }
        else {
            switch(opcode) {
                case Jalr: if (reg0 != 0) {xregs[reg0] = pc+4;} pc = xregs[reg1] + imm; break;
                case Lw: 
                    { int addr = (xregs[reg1] + imm)/4;
                    if (addr < -1 || addr >= memory_size) {
                        std::cerr << "error: memory outof range. pc = " << pc << std::endl;
                        exit(1);
                    }
                    xregs[reg0] = memory.at(addr); pc+=4;} break;
                case Sw: 
                    {int addr = xregs[reg1] + imm;
                    if (addr != -1) {
                        if (addr/4 < -1 || addr/4 >= memory_size) {
                            std::cerr << "error: memory outof range. pc = " << pc << std::endl;
                            exit(1);
                        }
                        memory.at(addr/4) = xregs[reg0];
                    }
                    else fprintf(fp, "%d\n", xregs[reg0]);
                    pc+=4;} break;
                default: 
                    std::cerr << "error occurred: line " << line << std::endl;
                    std::cerr << "current pc = " << pc << std::endl;
                    std::cerr << "instruction-execution error" << std::endl;
                    exit(1);
            }
        }
    }
    else if (opcode < 50) {
        if (opcode < 42) {
            switch(opcode) {
                case Beq: if (xregs[reg0] == xregs[reg1]) {pc += imm;} else {pc+=4;} break;
                case Ble: if (xregs[reg0] <= xregs[reg1]) { pc += imm; } else {pc+=4;} break;
                default: 
                    std::cerr << "error occurred: line " << line << std::endl;
                    std::cerr << "current pc = " << pc << std::endl;
                    std::cerr << "instruction-execution error" << std::endl;
                    exit(1);
            }
        }
        else {
            switch(opcode) {
                case Bge: if (xregs[reg0] >= xregs[reg1]) {pc += imm;} else {pc+=4;} break;
                case Jal: xregs[reg0] = pc + 4; pc += imm; break;
                case Lui: xregs[reg0] = (imm >> 12) << 12; pc+=4; break;
                default: 
                    std::cerr << "error occurred: line " << line << std::endl;
                    std::cerr << "current pc = " << pc << std::endl;
                    std::cerr << "instruction-execution error" << std::endl;
                    exit(1);
            }
        }
    }
    else if (opcode < 60) {
        std::cerr << "this is end-point" << std::endl;
    }
    else {
        std::cerr << "this is data section" << std::endl;
    }

    xregs[0] = 0;

    if (breakpoint || brkallflag) {
        std::cout << "\t" << filename << ", line " << line << std::endl;
        std::cout << "\t";
        Instruction::print_debug(stdout);
        std::cout << "\n\n";

        globalfun::print_regs(binflag);

        std::cout << "\n\tcurrent pc = " << pc << std::endl;
        std::cout << "\n<<< PRESS ENTER" << std::endl;
        
        getchar();
    }

    return pc;
}

inline void Instruction::set_machine_R(std::bitset<32> *mcode){
    *mcode |= std::bitset<32>(reg2) << 20;
    *mcode |= std::bitset<32>(reg1) << 15;
    *mcode |= std::bitset<32>(reg0) << 7;
}

inline void Instruction::set_machine_I(std::bitset<32> *mcode) { 
    *mcode |= std::bitset<32>(imm) << 20;
    *mcode |= std::bitset<32>(reg1) << 15;
    *mcode |= std::bitset<32>(reg0) << 7;
}

inline void Instruction::set_machine_S(std::bitset<32> *mcode) {
    *mcode |= std::bitset<32>(imm >> 5) << 25;
    *mcode |= std::bitset<32>(reg0) << 20;
    *mcode |= std::bitset<32>(reg1) << 15;
    *mcode |= (std::bitset<32>(imm % (1 << 5)) << 7) & std::bitset<32>((1 << 12) - 1);
}

inline void Instruction::set_machine_B(std::bitset<32> *mcode) {
    *mcode |= std::bitset<32>(imm >> 6) << 25;
    *mcode |= std::bitset<32>(reg1) << 20;
    *mcode |= std::bitset<32>(reg0) << 15;
    *mcode |= (std::bitset<32>((imm >> 1) % (1 << 5)) << 7) & std::bitset<32>((1 << 12) - 1);  
}

inline void Instruction::set_machine_U(std::bitset<32> *mcode) {
    *mcode |= std::bitset<32>(imm >> 12) << 12;
    *mcode |= std::bitset<32>(reg0) << 7;
}

inline void Instruction::set_machine_J(std::bitset<32> *mcode) {
    *mcode |= std::bitset<32>(imm >> 1) << 12;
    *mcode |= std::bitset<32>(reg0) << 7;
}

inline void Instruction::assemble(FILE *fp, int i) {
    fprintf(fp, "mem[13'd%d] <= 32'b", i);

    std::bitset<32> ret_machine;
    if (opcode < 10) {
        switch(opcode) {
            case Add: 
                ret_machine = add_machine; set_machine_R(&ret_machine); break;
            case Sub:
                ret_machine = sub_machine; set_machine_R(&ret_machine); break;
            case Slt: 
                ret_machine = slt_machine; set_machine_R(&ret_machine); break;
            case Mul: 
                ret_machine = mul_machine; set_machine_R(&ret_machine); break;
            case Div: 
                ret_machine = div_machine; set_machine_R(&ret_machine); break;
        }       
    }
    else if (opcode < 20) {
        switch(opcode) {
            case Fadd_s:
                ret_machine = fadd_machine; set_machine_R(&ret_machine); break;
            case Fsub_s:
                ret_machine = fsub_machine; set_machine_R(&ret_machine); break;
            case Fmul_s:
                ret_machine = fmul_machine; set_machine_R(&ret_machine); break;
            case Fdiv_s:
                ret_machine = fdiv_machine; set_machine_R(&ret_machine); break;
        }
    }
    else if (opcode < 30) {
        switch(opcode) {            
            case Feq_s:
                ret_machine = feq_machine; set_machine_R(&ret_machine); break;
            case Fle_s:
                ret_machine = fle_machine; set_machine_R(&ret_machine); break;
            case Flw: 
                ret_machine = flw_machine; set_machine_I(&ret_machine); break;
            case Fsw: 
                ret_machine = fsw_machine; set_machine_S(&ret_machine); break;
            case Fsqrt_s: 
                ret_machine = fsqrt_machine; set_machine_R(&ret_machine); break;
        }
    }
    else if (opcode < 40) {
        switch(opcode) {
            case Addi:
                ret_machine = addi_machine; set_machine_I(&ret_machine); break;
            case Ori: 
                ret_machine = ori_machine; set_machine_I(&ret_machine); break;
            case Jalr: 
                ret_machine = jalr_machine; set_machine_I(&ret_machine); break;
            case Lw:     
                ret_machine = lw_machine; set_machine_I(&ret_machine); break;
            case Sw:
                ret_machine = sw_machine; set_machine_S(&ret_machine); break;
        }
    }
    else if (opcode < 50) {
        switch(opcode) {
            case Beq: 
                ret_machine = beq_machine; set_machine_B(&ret_machine); break;
            case Ble:
                ret_machine = ble_machine; set_machine_B(&ret_machine); break;
            case Bge: 
                ret_machine = bge_machine; set_machine_B(&ret_machine); break;            
            case Jal:
                ret_machine = jal_machine; set_machine_J(&ret_machine); break;
            case Lui: 
                ret_machine = lui_machine; set_machine_U(&ret_machine); break;
        }
    }
    else if (opcode < 60) {
        ret_machine = std::bitset<32>(-1);
    }
    else {
        ret_machine = std::bitset<32>(imm);
    }
    std::string ret_machine_str = ret_machine.to_string();
    fprintf(fp, "%s;\n", ret_machine_str.c_str());

    if (i < 0 || i >= memory_size) {
        std::cerr << "error: memory outof range. address = " << i << std::endl;
        exit(1);        
    }
    memory.at(i) = (int)(ret_machine.to_ullong());
}