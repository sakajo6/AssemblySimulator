#pragma once

#include <vector>
#include <math.h>
#include <bitset>
#include <stdlib.h>
#include <iostream>

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
        int oprand0, oprand1, oprand2;
        int imm;
        bool breakpoint;

        void set_machine_R(std::bitset<32> *mcode);
        void set_machine_I(std::bitset<32> *mcode);
        void set_machine_S(std::bitset<32> *mcode);
        void set_machine_B(std::bitset<32> *mcode);
        void set_machine_U(std::bitset<32> *mcode);
        void set_machine_J(std::bitset<32> *mcode);

    public:
        Opcode opcode;
        int line;
        Instruction() {}
        Instruction(int ln, Opcode opc, int opr0, int opr1, int opr2, int im, bool brkp) {
            line = ln;
            opcode = opc;
            oprand0 = opr0;
            oprand1 = opr1;
            oprand2 = opr2;
            imm = im;
            breakpoint = brkp;
        }
        void print_debug(FILE *fp);
        int exec(int pc);
        void assemble(FILE *fp, int i);
};

inline void Instruction::print_debug(FILE *fp) {
    fprintf(fp, "%s ", opcode_to_string[opcode].c_str());
    if (oprand0 != -1) fprintf(fp, "a%d ", oprand0);
    if (oprand1 != -1) fprintf(fp, "a%d ", oprand1);
    if (oprand2 != -1) fprintf(fp, "a%d ", oprand2);
    if (imm != -1) fprintf(fp, "%d ", imm);
    fprintf(fp, "\n");
}

inline int Instruction::exec(int pc) {
    if (opcode < 50) {
        switch(opcode) {
            // pattern 0
            // op ope0, ope1, op2
            case Add: xregs[oprand0] = xregs[oprand1] + xregs[oprand2]; pc+=4; break;
            case Sub: xregs[oprand0] = xregs[oprand1] - xregs[oprand2]; pc+=4; break;
            case Slt: if (xregs[oprand1] < xregs[oprand2]) {xregs[oprand0] = 1;} else {xregs[oprand0] = 0;}; pc+=4; break;
            case Mul: xregs[oprand0] = xregs[oprand1] * xregs[oprand2]; pc+=4; break;
            case Div: xregs[oprand0] = xregs[oprand1] / xregs[oprand2]; pc+=4; break;
            default: 
                std::cout << "error occurred: line " << line << std::endl;
                std::cout << "current pc = " << pc << std::endl;
                std::cerr << "instruction-execution error" << std::endl;
                exit(1);
        }      
    }
    else if (opcode < 100) {
        switch(opcode) {
            case Fadd_s: fregs[oprand0] = fregs[oprand1] + fregs[oprand2]; pc+=4; break;
            case Fsub_s: fregs[oprand0] = fregs[oprand1] - fregs[oprand2]; pc+=4; break;
            case Fmul_s: fregs[oprand0] = fregs[oprand1] * fregs[oprand2]; pc+=4; break;
            case Fdiv_s: fregs[oprand0] = fregs[oprand1] / fregs[oprand2]; pc+=4; break;
            case Feq_s: if (fregs[oprand1] == fregs[oprand2]) {fregs[oprand0] = 1;} else {fregs[oprand0] = 0;}; pc+=4; break;
            case Flt_s: if (fregs[oprand1] < fregs[oprand2]) {fregs[oprand0] = 1;} else {fregs[oprand0] = 0;}; pc+=4; break;
            default: 
                std::cout << "error occurred: line " << line << std::endl;
                std::cout << "current pc = " << pc << std::endl;
                std::cerr << "instruction-execution error" << std::endl;
                exit(1);
        }
    }
    else if (opcode < 200) {
        switch(opcode) {          
            // pattern 1
            // op ope0, ope1, imm
            case Addi: xregs[oprand0] = xregs[oprand1] + imm; pc+=4; break;
            case Ori: xregs[oprand0] = xregs[oprand1] | imm; pc+=4; break;
            case Jalr: if (oprand0 != 0) {xregs[oprand0] = pc+4;} pc = xregs[oprand1] + imm; break;
            default: 
                std::cout << "error occurred: line " << line << std::endl;
                std::cout << "current pc = " << pc << std::endl;
                std::cerr << "instruction-execution error" << std::endl;
                exit(1);
        }
    }
    else if (opcode < 300) {
        switch(opcode) {
            // pattern 2
            // op ope0, imm(op1)
            case Lw: xregs[oprand0] = memory[(xregs[oprand1] + imm)/4]; pc+=4; break;
            case Sw: memory[(xregs[oprand1] + imm)/4] = xregs[oprand0]; pc+=4; break;
            case Flw: fregs[oprand0] = memory[(xregs[oprand1] + imm)/4]; pc+=4; break;
            case Fsw: memory[(xregs[oprand1] + imm)/4] = fregs[oprand0]; pc+=4; break;
            default: 
                std::cout << "error occurred: line " << line << std::endl;
                std::cout << "current pc = " << pc << std::endl;
                std::cerr << "instruction-execution error" << std::endl;
                exit(1);
        }
    }
    else if (opcode < 400) {
        switch(opcode) {
            // pattern 3
            // op ope0, ope1, label
            case Beq: if (xregs[oprand0] == xregs[oprand1]) {pc += imm;} else {pc+=4;} break;
            case Ble: if (xregs[oprand0] <= xregs[oprand1]) { pc += imm; } else {pc+=4;} break;
            case Bge: if (xregs[oprand0] >= xregs[oprand1]) {pc += imm;} else {pc+=4;} break;
            default: 
                std::cout << "error occurred: line " << line << std::endl;
                std::cout << "current pc = " << pc << std::endl;
                std::cerr << "instruction-execution error" << std::endl;
                exit(1);
        }
    }
    else if (opcode < 500) {
        switch(opcode) {
            // pattern 4
            // op ope0, label
            case Jal: xregs[oprand0] = pc + 4; pc += imm; break;
            default: 
                std::cout << "error occurred: line " << line << std::endl;
                std::cout << "current pc = " << pc << std::endl;
                std::cerr << "instruction-execution error" << std::endl;
                exit(1);
        }
    }
    else if (opcode < 600) {
        switch(opcode) {            
            // pattern 5
            // op ope0, ope1
            case Fsqrt_s: fregs[oprand0] = sqrt(fregs[oprand1]); pc+=4; break;
            default: 
                std::cout << "error occurred: line " << line << std::endl;
                std::cout << "current pc = " << pc << std::endl;
                std::cerr << "instruction-execution error" << std::endl;
                exit(1);
        }
    }
    else if (opcode < 700) {
        switch(opcode) {
            // pattern 6
            // op ope0, imm
            case Lui: xregs[oprand0] = (imm >> 12) << 12; pc+=4; break;
            default: 
                std::cout << "error occurred: line " << line << std::endl;
                std::cout << "current pc = " << pc << std::endl;
                std::cerr << "instruction-execution error" << std::endl;
                exit(1);
        }
    }

    xregs[0] = 0;

    if (breakpoint) {
        int rownum = 8;
        int colnum = 32/rownum;

        std::cout << "\texecuted: line " << line << std::endl;
        std::cout << "\t";
        print_debug(stdout);
        std::cout << "\n";
        for(int i = 0; i < rownum; i++) {
            std::cout << '\t';
            for(int j = 0; j < colnum; j++) {
                std::cout << "x" << i*colnum + j;
                if ((i*colnum + j)/10 == 0) std::cout << "  ";
                else std::cout << " ";
                std::cout << "0x" << std::hex << xregs[i*colnum + j] << std::dec << ",\t";
            }
            std::cout << "\n";
        }
        // std::cout << "\n";
        // for(int i = 0; i < rownum; i++) {
        //     std::cout << '\t';
        //     for(int j = 0; j < colnum; j++) {
        //         std::cout << "f" << i*colnum + j << ":\t";
        //         std::cout << std::hex << fregs[i*colnum + j] << std::dec << ",\t";
        //     }
        //     std::cout << "\n";
        // }
        std::cout << "\n\tcurrent pc = " << pc << std::endl;
        std::cout << "\n<<< PRESS ENTER" << std::endl;
        
        getchar();
    }

    return pc;
}

inline void Instruction::set_machine_R(std::bitset<32> *mcode){
    *mcode |= std::bitset<32>(oprand2) << 20;
    *mcode |= std::bitset<32>(oprand1) << 15;
    *mcode |= std::bitset<32>(oprand0) << 7;
}

inline void Instruction::set_machine_I(std::bitset<32> *mcode) { 
    *mcode |= std::bitset<32>(imm) << 20;
    *mcode |= std::bitset<32>(oprand1) << 15;
    *mcode |= std::bitset<32>(oprand0) << 7;
}

inline void Instruction::set_machine_S(std::bitset<32> *mcode) {
    *mcode |= std::bitset<32>(imm >> 5) << 25;
    *mcode |= std::bitset<32>(oprand0) << 20;
    *mcode |= std::bitset<32>(oprand1) << 15;
    *mcode |= (std::bitset<32>(imm % (1 << 5)) << 7) & std::bitset<32>((1 << 12) - 1);
}

inline void Instruction::set_machine_B(std::bitset<32> *mcode) {
    *mcode |= std::bitset<32>(imm >> 6) << 25;
    *mcode |= std::bitset<32>(oprand1) << 20;
    *mcode |= std::bitset<32>(oprand0) << 15;
    *mcode |= (std::bitset<32>((imm >> 1) % (1 << 5)) << 7) & std::bitset<32>((1 << 12) - 1);  
}

inline void Instruction::set_machine_U(std::bitset<32> *mcode) {
    *mcode |= std::bitset<32>(imm >> 12) << 12;
    *mcode |= std::bitset<32>(oprand0) << 7;
}

inline void Instruction::set_machine_J(std::bitset<32> *mcode) {
    *mcode |= std::bitset<32>(imm >> 1) << 12;
    *mcode |= std::bitset<32>(oprand0) << 7;
}


inline void Instruction::assemble(FILE *fp, int i) {
    fprintf(fp, "mem[13'd%d] <= 32'b", i);

    std::bitset<32> ret_machine;
    if (opcode < 50) {
        switch(opcode) {
            // pattern 0
            // op ope0, ope1, op2
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
    else if (opcode < 100) {
        switch(opcode) {
            case Fadd_s:
                ret_machine = fadd_machine; set_machine_R(&ret_machine); break;
            case Fsub_s:
                ret_machine = fsub_machine; set_machine_R(&ret_machine); break;
            case Fmul_s:
                ret_machine = fmul_machine; set_machine_R(&ret_machine); break;
            case Fdiv_s:
                ret_machine = fdiv_machine; set_machine_R(&ret_machine); break;
            case Feq_s:
                ret_machine = feq_machine; set_machine_R(&ret_machine); break;
            case Flt_s:
                ret_machine = flt_machine; set_machine_R(&ret_machine); break;
        }
    }
    else if (opcode < 200) {
        switch(opcode) {            
            // pattern 1
            case Addi:
                ret_machine = addi_machine; set_machine_I(&ret_machine); break;
            case Ori: 
                ret_machine = ori_machine; set_machine_I(&ret_machine); break;
            case Jalr: 
                ret_machine = jalr_machine; set_machine_I(&ret_machine); break;
        }
    }
    else if (opcode < 300) {
        switch(opcode) {
            // pattern 2
            case Lw:     
                ret_machine = lw_machine; set_machine_I(&ret_machine); break;
            case Sw:
                ret_machine = sw_machine; set_machine_S(&ret_machine); break;
            case Flw: 
                ret_machine = flw_machine; set_machine_I(&ret_machine); break;
            case Fsw: 
                ret_machine = fsw_machine; set_machine_S(&ret_machine); break;
        }
    }
    else if (opcode < 400) {
        switch(opcode) {
            // pattern 3
            case Beq: 
                ret_machine = beq_machine; set_machine_B(&ret_machine); break;
            case Ble:
                ret_machine = ble_machine; set_machine_B(&ret_machine); break;
            case Bge: 
                ret_machine = bge_machine; set_machine_B(&ret_machine); break;            
        }
    }
    else if (opcode < 500) {
        switch(opcode) {
            // pattern 4
            case Jal:
                ret_machine = jal_machine; set_machine_J(&ret_machine); break;
        }
    }
    else if (opcode < 600) {
        switch(opcode) {            
            // pattern 5
            case Fsqrt_s: 
                ret_machine = fsqrt_machine; set_machine_R(&ret_machine); break;
        }
    }
    else if (opcode < 700) {
        switch(opcode) {
            // pattern 6
            case Lui: 
                ret_machine = lui_machine; set_machine_U(&ret_machine); break;
        }
    }
    std::string ret_machine_str = ret_machine.to_string();
    fprintf(fp, "%s;\n", ret_machine_str.c_str());
}
