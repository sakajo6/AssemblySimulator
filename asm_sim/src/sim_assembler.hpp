#pragma once

#include <vector>
#include <bitset>
#include <assert.h>
#include <string>

#include "sim_instruction.hpp"
#include "sim_machinecode.hpp"

enum OpeAssert {
    OK,
    Reg0Err,
    Reg1Err,
    Reg2Err,
    ImmErr,
    MemoryOutOfRange,
};

class Assembler {
    private:
        OpeAssert set_machine_R(std::bitset<32> *);
        OpeAssert set_machine_sqrt(std::bitset<32> *);
        OpeAssert set_machine_I(std::bitset<32> *);
        OpeAssert set_machine_S(std::bitset<32> *);
        OpeAssert set_machine_B(std::bitset<32> *);
        OpeAssert set_machine_U(std::bitset<32> *);
        OpeAssert set_machine_J(std::bitset<32> *);

        Opcode opcode;
        int reg0, reg1, reg2, imm;
        float fimm;

        FILE *fp;
        FILE *fpdebug;

        void assemble_debug(std::bitset<32>);

    public:
        Assembler(Instruction inst, FILE *fp_, FILE *fpdebug_) {
            opcode = inst.opcode;

            reg0 = inst.reg0;
            reg1 = inst.reg1;
            reg2 = inst.reg2;
            imm = inst.imm;
            fimm = inst.fimm;

            fp = fp_;
            fpdebug = fpdebug_;
        }
        OpeAssert assemble(int, bool);
};

inline void Assembler::assemble_debug(std::bitset<32> mcode){
    std::string s = mcode.to_string();
    
    // 31 - 27
    fprintf(fpdebug, "%s|", s.substr(0, 5).c_str());
    // 26 - 25
    fprintf(fpdebug, "%s|", s.substr(5, 2).c_str());
    // 24 - 20
    fprintf(fpdebug, "%s|", s.substr(7, 5).c_str());
    // 19 - 15
    fprintf(fpdebug, "%s|", s.substr(12, 5).c_str());
    // 14 - 12
    fprintf(fpdebug, "%s|", s.substr(17, 3).c_str());
    // 11 - 7
    fprintf(fpdebug, "%s|", s.substr(20, 5).c_str());
    // 6 - 2
    fprintf(fpdebug, "%s|", s.substr(25, 5).c_str());
    // 1 - 0
    fprintf(fpdebug, "%s\n", s.substr(30, 2).c_str());
}

inline OpeAssert Assembler::set_machine_R(std::bitset<32> *mcode){
    if (reg0 < 0 || reg0 >= 32) return Reg0Err;
    if (reg1 < 0 || reg1 >= 32) return Reg1Err;
    if (reg2 < 0 || reg2 >= 32) return Reg2Err;

    fprintf(fpdebug, "\nR: %s\n", opcode_to_string[opcode].c_str());
    assemble_debug(*mcode);

    fprintf(fpdebug, "%d\n", reg2);
    assemble_debug(std::bitset<32>(reg2));
    assemble_debug(std::bitset<32>(reg2) << 20);

    fprintf(fpdebug, "%d\n", reg1);
    assemble_debug(std::bitset<32>(reg1));
    assemble_debug(std::bitset<32>(reg1) << 15);

    fprintf(fpdebug, "%d\n", reg0);
    assemble_debug(std::bitset<32>(reg0));
    assemble_debug(std::bitset<32>(reg0) << 7);

    *mcode |= std::bitset<32>(reg2) << 20;
    *mcode |= std::bitset<32>(reg1) << 15;
    *mcode |= std::bitset<32>(reg0) << 7;

    assemble_debug(*mcode);

    return OK;
}

inline OpeAssert Assembler::set_machine_sqrt(std::bitset<32> *mcode) {
    if (reg0 < 0 || reg0 >= 32) return Reg0Err;
    if (reg1 < 0 || reg1 >= 32) return Reg1Err;

    fprintf(fpdebug, "\nsqrt: %s\n", opcode_to_string[opcode].c_str());
    assemble_debug(*mcode);

    fprintf(fpdebug, "%d\n", reg1);
    assemble_debug(std::bitset<32>(reg1));
    assemble_debug(std::bitset<32>(reg1) << 15);

    fprintf(fpdebug, "%d\n", reg0);
    assemble_debug(std::bitset<32>(reg0));
    assemble_debug(std::bitset<32>(reg0) << 7);

    *mcode |= std::bitset<32>(reg1) << 15;
    *mcode |= std::bitset<32>(reg0) << 7;

    assemble_debug(*mcode);

    return OK;
}

inline OpeAssert Assembler::set_machine_I(std::bitset<32> *mcode) { 
    if (reg0 < 0 || reg0 >= 32) return Reg0Err;
    if (reg1 < 0 || reg1 >= 32) return Reg1Err;
    if (imm < -(1 << 11) || imm > (1 << 11) - 1) return ImmErr;

    fprintf(fpdebug, "\nI: %s\n", opcode_to_string[opcode].c_str());
    assemble_debug(*mcode);

    fprintf(fpdebug, "%d\n", imm);
    assemble_debug(std::bitset<32>(imm));
    assemble_debug(std::bitset<32>(imm) << 20);

    fprintf(fpdebug, "%d\n", reg1);
    assemble_debug(std::bitset<32>(reg1));
    assemble_debug(std::bitset<32>(reg1) << 15);

    fprintf(fpdebug, "%d\n", reg0);
    assemble_debug(std::bitset<32>(reg0));
    assemble_debug(std::bitset<32>(reg0) << 7);

    *mcode |= std::bitset<32>(imm) << 20;
    *mcode |= std::bitset<32>(reg1) << 15;
    *mcode |= std::bitset<32>(reg0) << 7;

    assemble_debug(*mcode);

    return OK;
}

inline OpeAssert Assembler::set_machine_S(std::bitset<32> *mcode) {
    if (reg0 < 0 || reg0 >= 32) return Reg0Err;
    if (reg1 < 0 || reg1 >= 32) return Reg1Err;
    if (imm < -(1 << 11) || imm > (1 << 11) - 1) return ImmErr;

    fprintf(fpdebug, "\nS: %s\n", opcode_to_string[opcode].c_str());
    assemble_debug(*mcode);

    fprintf(fpdebug, "%d\n", imm);
    assemble_debug(std::bitset<32>(imm));
    assemble_debug(std::bitset<32>(imm >> 5) << 25);

    fprintf(fpdebug, "%d\n", reg0);
    assemble_debug(std::bitset<32>(reg0));
    assemble_debug(std::bitset<32>(reg0) << 20);

    fprintf(fpdebug, "%d\n", reg1);
    assemble_debug(std::bitset<32>(reg1));
    assemble_debug(std::bitset<32>(reg1) << 15);

    fprintf(fpdebug, "%d\n", imm);
    assemble_debug(std::bitset<32>(imm));
    assemble_debug((std::bitset<32>(imm % (1 << 5)) << 7) & std::bitset<32>((1 << 12) - 1));

    *mcode |= std::bitset<32>(imm >> 5) << 25;
    *mcode |= std::bitset<32>(reg0) << 20;
    *mcode |= std::bitset<32>(reg1) << 15;
    *mcode |= (std::bitset<32>(imm % (1 << 5)) << 7) & std::bitset<32>((1 << 12) - 1);

    assemble_debug(*mcode);

    return OK;
}

inline OpeAssert Assembler::set_machine_B(std::bitset<32> *mcode) {
    if (reg0 < 0 || reg0 >= 32) return Reg0Err;
    if (reg1 < 0 || reg1 >= 32) return Reg1Err;
    if (imm < -(1 << 12) || imm > (1 << 12) - 1) return ImmErr;

    fprintf(fpdebug, "\nB: %s\n", opcode_to_string[opcode].c_str());
    assemble_debug(*mcode);

    fprintf(fpdebug, "%d\n", imm);
    assemble_debug(std::bitset<32>(imm));
    assemble_debug(std::bitset<32>(imm >> 6) << 25);

    fprintf(fpdebug, "%d\n", reg1);
    assemble_debug(std::bitset<32>(reg1));
    assemble_debug(std::bitset<32>(reg1) << 20);

    fprintf(fpdebug, "%d\n", reg0);
    assemble_debug(std::bitset<32>(reg0));
    assemble_debug(std::bitset<32>(reg0) << 15);

    fprintf(fpdebug, "%d\n", imm);
    assemble_debug(std::bitset<32>(imm));
    assemble_debug((std::bitset<32>((imm >> 1) % (1 << 5)) << 7) & std::bitset<32>((1 << 12) - 1));

    *mcode |= std::bitset<32>(imm >> 6) << 25;
    *mcode |= std::bitset<32>(reg1) << 20;
    *mcode |= std::bitset<32>(reg0) << 15;
    *mcode |= (std::bitset<32>((imm >> 1) % (1 << 5)) << 7) & std::bitset<32>((1 << 12) - 1);  

    assemble_debug(*mcode);

    return OK;
}

inline OpeAssert Assembler::set_machine_U(std::bitset<32> *mcode) {
    if (reg0 < 0 || reg0 >= 32) return Reg0Err;
    if ((long int)imm < -((long int)1 << 31) || (long int)imm > ((long int)1 << 31) - 1) return ImmErr;

    fprintf(fpdebug, "\nU: %s\n", opcode_to_string[opcode].c_str());
    assemble_debug(*mcode);

    fprintf(fpdebug, "%d\n", imm);
    assemble_debug(std::bitset<32>(imm));
    assemble_debug(std::bitset<32>(imm >> 12) << 12);

    fprintf(fpdebug, "%d\n", reg0);
    assemble_debug(std::bitset<32>(reg0));
    assemble_debug(std::bitset<32>(reg0) << 7);

    *mcode |= std::bitset<32>(imm >> 12) << 12;
    *mcode |= std::bitset<32>(reg0) << 7;

    assemble_debug(*mcode);

    return OK;
}

inline OpeAssert Assembler::set_machine_J(std::bitset<32> *mcode) {
    if (reg0 < 0 || reg0 >= 32) return Reg0Err;
    if (imm < -(1 << 20) || imm > (1 << 20) - 1) return ImmErr;

    fprintf(fpdebug, "\nJ: %s\n", opcode_to_string[opcode].c_str());
    assemble_debug(*mcode);

    fprintf(fpdebug, "%d\n", imm);
    assemble_debug(std::bitset<32>(imm));
    assemble_debug(std::bitset<32>(imm >> 1) << 12);

    fprintf(fpdebug, "%d\n", reg0);
    assemble_debug(std::bitset<32>(reg0));
    assemble_debug(std::bitset<32>(reg0) << 7);

    *mcode |= std::bitset<32>(imm >> 1) << 12;
    *mcode |= std::bitset<32>(reg0) << 7;

    assemble_debug(*mcode);

    return OK;
}

inline OpeAssert Assembler::assemble(int pc, bool veriflag) {
    if (veriflag) fprintf(fp, "mem[13'd%d] <= 32'b", pc/4);
    
    std::bitset<32> ret_machine;
    OpeAssert ret = OK;
    if (opcode < 50) {
        switch(opcode) {
            case Add: 
                ret_machine = add_machine; ret = set_machine_R(&ret_machine); break;
            case Sub:
                ret_machine = sub_machine; ret = set_machine_R(&ret_machine); break;
            case Slt: 
                ret_machine = slt_machine; ret = set_machine_R(&ret_machine); break;
            case Mul: 
                ret_machine = mul_machine; ret = set_machine_R(&ret_machine); break;
            case Div: 
                ret_machine = div_machine; ret = set_machine_R(&ret_machine); break;
            case Fadd:
                ret_machine = fadd_machine; ret = set_machine_R(&ret_machine); break;
            case Fsub:
                ret_machine = fsub_machine; ret = set_machine_R(&ret_machine); break;
            case Fmul:
                ret_machine = fmul_machine; ret = set_machine_R(&ret_machine); break;
            case Fdiv:
                ret_machine = fdiv_machine; ret = set_machine_R(&ret_machine); break;
            case Feq:
                ret_machine = feq_machine; ret = set_machine_R(&ret_machine); break;
            case Fle:
                ret_machine = fle_machine; ret = set_machine_R(&ret_machine); break;
            case Flw: 
                ret_machine = flw_machine; ret = set_machine_I(&ret_machine); break;
            case Fsw: 
                ret_machine = fsw_machine; ret = set_machine_S(&ret_machine); break;
            case Fsqrt: 
                ret_machine = fsqrt_machine; ret = set_machine_sqrt(&ret_machine); break;
            case Addi:
                ret_machine = addi_machine; ret = set_machine_I(&ret_machine); break;
            case Ori: 
                ret_machine = ori_machine; ret = set_machine_I(&ret_machine); break;
            case Jalr: 
                ret_machine = jalr_machine; ret = set_machine_I(&ret_machine); break;
            case Lw:     
                ret_machine = lw_machine; ret = set_machine_I(&ret_machine); break;
            case Sw:
                ret_machine = sw_machine; ret = set_machine_S(&ret_machine); break;
            case Beq: 
                ret_machine = beq_machine; ret = set_machine_B(&ret_machine); break;
            case Ble:
                ret_machine = ble_machine; ret = set_machine_B(&ret_machine); break;
            case Bge: 
                ret_machine = bge_machine; ret = set_machine_B(&ret_machine); break;            
            case Jal:
                ret_machine = jal_machine; ret = set_machine_J(&ret_machine); break;
            case Lui: 
                ret_machine = lui_machine; ret = set_machine_U(&ret_machine); break;
        }
    }
    else if (opcode < 60) {
        ret_machine = std::bitset<32>(-1);
    }
    else {
        U u;
        u.f = fimm;
        ret_machine = std::bitset<32>(u.i);
    }

    if (pc < 0 || pc >= memory_size) {
        return MemoryOutOfRange;
    }
    memory.at(pc).i = (unsigned int)(ret_machine.to_ulong());
    if (veriflag) {
        std::string ret_machine_str = ret_machine.to_string();
        fprintf(fp, "%s;\n", ret_machine_str.c_str());
    }
    else {
        fprintf(fp, "%08x\n", (unsigned int)memory.at(pc).i);
    }

    return ret;
}