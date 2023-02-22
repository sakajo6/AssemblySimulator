#pragma once

#include <bitset>
#include <string>

#include "instruction.hpp"
#include "opecode.hpp"
#include "global.hpp"

enum AsmError {
    Asm_OK,
    Asm_OpErr,      // unmatch opecode
    Asm_Reg0Err,    // unmatch reg0
    Asm_Reg1Err,    // unmatch reg1
    Asm_Reg2Err,    // unmatch reg2
    Asm_ImmErr,     // unmatch imm
    Asm_FimmErr,    // unmatch fimm
    Asm_EncErr,     // invalid machine code
    Asm_Unknown,    // unknown error
};

enum EncType {
    EXIT_type,
    Float_type,
    Addi_type,
    Fsqrt_type,
    R_type,
    I_type,
    S_type,
    B_type,
    U_type,
    J_type,
};

class Decoder {
    private:
        std::bitset<32> *bin;           // machine code
        std::string     bin_str;        // string of machine code
        Instruction     encoded_inst;   // instruction before encoding
        Instruction     decoded_inst;   // instruction after encoding

        FILE *fpdebug;  // output to bin_debug.txt

        AsmError decode_assert(EncType);

        AsmError decode_EXIT();     // EXIT
        AsmError decode_float();    // float
        AsmError decode_addi();     // addi
        AsmError decode_fsqrt();    // fsqrt
        AsmError decode_R();        // R-type
        AsmError decode_I();        // I-type
        AsmError decode_S();        // S-type
        AsmError decode_B();        // B-type
        AsmError decode_U();        // U-type
        AsmError decode_J();        // J-type

    public:
        Decoder(std::bitset<32> *bin_, Instruction *inst, FILE *fpdebug_) {
            bin = bin_;
            bin_str = (*bin_).to_string();
            encoded_inst = *inst;
            fpdebug = fpdebug_;

            // initialization for instruction after encoding
            decoded_inst.reg0 = INT_MAX;
            decoded_inst.reg1 = INT_MAX;
            decoded_inst.reg2 = INT_MAX;
            decoded_inst.imm = INT_MAX;
            decoded_inst.fimm = FLT_MAX;
        }
        void decode();
};

AsmError Decoder::decode_assert(EncType enc_type) {
    if (decoded_inst.opcode != encoded_inst.opcode) return Asm_OpErr;
    if (decoded_inst.reg0 != encoded_inst.reg0) return Asm_Reg0Err;
    if (decoded_inst.reg1 != encoded_inst.reg1) return Asm_Reg1Err;
    if (decoded_inst.reg2 != encoded_inst.reg2) return Asm_Reg2Err;

    if (enc_type == Addi_type) {
        if (std::bitset<17>(decoded_inst.imm) != std::bitset<17>(encoded_inst.imm)) return Asm_ImmErr;
    }
    else if (enc_type == I_type) {
        if (std::bitset<12>(decoded_inst.imm) != std::bitset<12>(encoded_inst.imm)) return Asm_ImmErr;
    }
    else if (enc_type == S_type) {
        if (std::bitset<12>(decoded_inst.imm) != std::bitset<12>(encoded_inst.imm)) return Asm_ImmErr;
    }
    else if (enc_type == B_type) {
        if (std::bitset<15>(decoded_inst.imm) != std::bitset<15>(encoded_inst.imm)) return Asm_ImmErr;
    }
    else if (enc_type == U_type) {
        if (std::bitset<20>(decoded_inst.imm >> 12) != std::bitset<20>(encoded_inst.imm >> 12)) return Asm_ImmErr;
    }
    else if (enc_type == J_type) {
        if (std::bitset<21>(decoded_inst.imm) != std::bitset<21>(encoded_inst.imm)) return Asm_ImmErr;
    }
    else {
        if (std::bitset<32>(decoded_inst.imm) != std::bitset<32>(encoded_inst.imm)) return Asm_ImmErr;
    }

    if (decoded_inst.fimm != encoded_inst.fimm) return Asm_FimmErr;

    return Asm_OK;
}

AsmError Decoder::decode_EXIT() {
    // condition:
    // bin_str == "11111111111111111111111111111111"
    
    // decoded inst
    decoded_inst.opcode = Exit;

    // assert check
    return decode_assert(EXIT_type);
}

AsmError Decoder::decode_float() {
    // condition:
    // encoded_inst.opcode == Word

    // decoded inst
    decoded_inst.opcode = Word;

    auto fimm_machine = (*bin).to_ulong();
    U u; u.i = (unsigned int)fimm_machine;
    decoded_inst.fimm = u.f;

    // assert check
    return decode_assert(Float_type);
}

AsmError Decoder::decode_addi() {
    // condition:
    // bin_str.substr(17, 3) == "000" && bin_str.substr(27, 2) == "11"

    // decoded inst
    decoded_inst.opcode = Addi;
    decoded_inst.reg0 = (int)std::bitset<5>(bin_str.substr(20, 5)).to_ulong();
    decoded_inst.reg1 = (int)std::bitset<5>(bin_str.substr(12, 5)).to_ulong();
    
    std::string imm_str = bin_str.substr(25, 2) + bin_str.substr(29, 3) + bin_str.substr(0, 12);
    decoded_inst.imm = (int)std::bitset<17>(imm_str).to_ulong();
    
    // assert check
    return decode_assert(Addi_type);
}

AsmError Decoder::decode_fsqrt() {
    // condition:
    // bin_str.substr(0, 12) == "010110000000" && bin_str.substr(25, 7) == "1010011"

    // decoded inst
    decoded_inst.opcode = Fsqrt;
    decoded_inst.reg0 = (int)std::bitset<5>(bin_str.substr(20, 5)).to_ulong();
    decoded_inst.reg1 = (int)std::bitset<5>(bin_str.substr(12, 5)).to_ulong();

    // assert check
    return decode_assert(Fsqrt_type);
}

AsmError Decoder::decode_R() {
    // condition:
    // bin_str.substr(25, 7) == "0110011" ||   // add, sub, slt, mul, div
    // bin_str.substr(25, 7) == "1010011"      // fadd, fsub, fmul, fdiv

    // decoded inst
    if (bin_str.substr(25, 7) == "0110011") {
        if (bin_str.substr(0, 7) == "0000000" && bin_str.substr(17, 3) == "000") decoded_inst.opcode = Add;
        else if (bin_str.substr(0, 7) == "0100000" && bin_str.substr(17, 3) == "000") decoded_inst.opcode = Sub;
        else if (bin_str.substr(0, 7) == "0000000" && bin_str.substr(17, 3) == "010") decoded_inst.opcode = Slt;
        else if (bin_str.substr(0, 7) == "0000001" && bin_str.substr(17, 3) == "000") decoded_inst.opcode = Mul;
        else if (bin_str.substr(0, 7) == "0000001" && bin_str.substr(17, 3) == "100") decoded_inst.opcode = Div;
        else return Asm_EncErr;
    }
    else if (bin_str.substr(25, 7) == "1010011") {
        if (bin_str.substr(0, 7) == "0000000") decoded_inst.opcode = Fadd;
        else if (bin_str.substr(0, 7) == "0000100") decoded_inst.opcode = Fsub;
        else if (bin_str.substr(0, 7) == "0001000") decoded_inst.opcode = Fmul;
        else if (bin_str.substr(0, 7) == "0001100") decoded_inst.opcode = Fdiv;
        else return Asm_EncErr;
    }
    else {
        return Asm_EncErr;
    }

    decoded_inst.reg0 = (int)std::bitset<5>(bin_str.substr(20, 5)).to_ulong();
    decoded_inst.reg1 = (int)std::bitset<5>(bin_str.substr(12, 5)).to_ulong();
    decoded_inst.reg2 = (int)std::bitset<5>(bin_str.substr(7, 5)).to_ulong();
 
    // assert check
    return decode_assert(R_type);
}

AsmError Decoder::decode_I() {
    // condition
    // bin_str.substr(25, 7) == "0000011" ||   // lw
    // bin_str.substr(25, 7) == "1100111" ||   // jalr
    // bin_str.substr(25, 7) == "0010011" ||   // ori
    // bin_str.substr(25, 7) == "0000111"   // flw

    // decoded inst
    if (bin_str.substr(17, 3) == "010" && bin_str.substr(25, 7) == "0000011") decoded_inst.opcode = Lw;
    else if (bin_str.substr(17, 3) == "000" && bin_str.substr(25, 7) == "1100111") decoded_inst.opcode = Jalr;
    else if (bin_str.substr(17, 3) == "110" && bin_str.substr(25, 7) == "0010011") decoded_inst.opcode = Ori;
    else if (bin_str.substr(17, 3) == "010" && bin_str.substr(25, 7) == "0000111") decoded_inst.opcode = Flw;
    else return Asm_EncErr;

    decoded_inst.reg0 = (int)std::bitset<5>(bin_str.substr(20, 5)).to_ulong();
    decoded_inst.reg1 = (int)std::bitset<5>(bin_str.substr(12, 5)).to_ulong();

    std::string imm_str = bin_str.substr(0, 12);
    decoded_inst.imm = (int)std::bitset<12>(imm_str).to_ulong();

    // assert check
    return decode_assert(I_type);
}

AsmError Decoder::decode_S() {
    // condition
    // bin_str.substr(25, 7) == "0100011" ||   // sw
    // bin_str.substr(25, 7) == "0100111"      // fsw

    // decoded inst
    if (bin_str.substr(17, 3) == "010" && bin_str.substr(25, 7) == "0100011") decoded_inst.opcode = Sw;
    else if (bin_str.substr(17, 3) == "010" && bin_str.substr(25, 7) == "0100111") decoded_inst.opcode = Fsw;
    else return Asm_EncErr;

    decoded_inst.reg0 = (int)std::bitset<5>(bin_str.substr(7, 5)).to_ulong();
    decoded_inst.reg1 = (int)std::bitset<5>(bin_str.substr(12, 5)).to_ulong();

    std::string imm_str = bin_str.substr(0, 7) + bin_str.substr(20, 5);
    decoded_inst.imm = (int)std::bitset<12>(imm_str).to_ulong();

    // assert check
    return decode_assert(S_type);
}

AsmError Decoder::decode_B() {
    // condition
    // bin_str.substr(25, 5) == "11000" ||     // beq, ble, bge
    // bin_str.substr(25, 5) == "00010"        // feq, fle

    // decoded inst
    if (bin_str.substr(25, 5) == "11000") {
        if (bin_str.substr(17, 3) == "000") decoded_inst.opcode = Beq;
        else if (bin_str.substr(17, 3) == "100") decoded_inst.opcode = Ble;
        else if (bin_str.substr(17, 3) == "101") decoded_inst.opcode = Bge;
        else return Asm_EncErr;
    }
    else if (bin_str.substr(25, 5) == "00010") {
        if (bin_str.substr(17, 3) == "010") decoded_inst.opcode = Feq;
        else if (bin_str.substr(17, 3) == "001") decoded_inst.opcode = Fle;
        else return Asm_EncErr;
    }
    else return Asm_EncErr;

    decoded_inst.reg0 = (int)std::bitset<5>(bin_str.substr(12, 5)).to_ulong();
    decoded_inst.reg1 = (int)std::bitset<5>(bin_str.substr(7, 5)).to_ulong();

    std::string imm_str = bin_str.substr(30, 2) + bin_str.substr(0, 7) + bin_str.substr(20, 5);
    decoded_inst.imm = (int)(std::bitset<14>(imm_str).to_ulong() << 1);

    // assert check
    return decode_assert(B_type);
}

AsmError Decoder::decode_U() {
    // condition
    // bin_str.substr(25, 7) == "0110111"  // lui

    // decode inst
    if (bin_str.substr(25, 7) == "0110111") decoded_inst.opcode = Lui;
    else return Asm_EncErr;

    decoded_inst.reg0 = (int)std::bitset<5>(bin_str.substr(20, 5)).to_ulong();

    std::string imm_str = bin_str.substr(0, 20);
    decoded_inst.imm = (int)(std::bitset<20>(imm_str).to_ulong() << 12);

    // assert check
    return decode_assert(U_type);
}

AsmError Decoder::decode_J() {
    // condition
    // bin_str.substr(25, 7) == "1101111"  // jal

    // decode inst
    if (bin_str.substr(25, 7) == "1101111") decoded_inst.opcode = Jal;
    else return Asm_EncErr;

    decoded_inst.reg0 = (int)std::bitset<5>(bin_str.substr(20, 5)).to_ulong();

    std::string imm_str = bin_str.substr(0, 20);
    decoded_inst.imm = (int)(std::bitset<20>(imm_str).to_ulong() << 1);

    // assert check
    return decode_assert(J_type);
}

void Decoder::decode() {
    AsmError asm_error;

    // EXIT
    if (bin_str == "11111111111111111111111111111111") {
        asm_error = decode_EXIT();
    }
    // float table
    else if (encoded_inst.opcode == Word) {
        asm_error = decode_float();
    }
    // addi
    else if (bin_str.substr(17, 3) == "000" && bin_str.substr(27, 2) == "11") {
        asm_error = decode_addi();
    }
    // fsqrt
    else if (bin_str.substr(0, 12) == "010110000000" && bin_str.substr(25, 7) == "1010011") {
        asm_error = decode_fsqrt();
    }
    // R-type
    else if (
        bin_str.substr(25, 7) == "0110011" ||   // add, sub, slt, mul, div
        bin_str.substr(25, 7) == "1010011"      // fadd, fsub, fmul, fdiv
    ) {
        asm_error = decode_R();
    }
    // I-type
    else if (
        bin_str.substr(25, 7) == "0000011" ||   // lw
        bin_str.substr(25, 7) == "1100111" ||   // jalr
        bin_str.substr(25, 7) == "0010011" ||   // ori
        bin_str.substr(25, 7) == "0000111"   // flw
    ) {
        asm_error = decode_I();
    }
    // S-type
    else if (
        bin_str.substr(25, 7) == "0100011" ||   // sw
        bin_str.substr(25, 7) == "0100111"      // fsw
    ) {
        asm_error = decode_S();
    }
    // B-type
    else if (
        bin_str.substr(25, 5) == "11000" ||     // beq, ble, bge
        bin_str.substr(25, 5) == "00010"        // feq, fle
    ) {
        asm_error = decode_B();
    }
    // U-type
    else if (
        bin_str.substr(25, 7) == "0110111"  // lui
    ) {
        asm_error = decode_U();
    }
    // J-type
    else if (
        bin_str.substr(25, 7) == "1101111"  // jal
    ) {
        asm_error = decode_J();
    }

    if (asm_error != Asm_OK) {
        fprintf(stdout, "opcode -> %s", opcode_to_string[encoded_inst.opcode].c_str());
    }
    if (asm_error == Asm_OpErr) {
        fprintf(fpdebug, "[error] (inavlid opcode) encoded: %d -> decoded: %d\n", encoded_inst.opcode, decoded_inst.opcode);
        fprintf(stdout, "[error] (inavlid opcode) encoded: %d -> decoded: %d\n", encoded_inst.opcode, decoded_inst.opcode);
    }
    else if (asm_error == Asm_Reg0Err) {
        fprintf(fpdebug, "[error] (invalid reg0) encoded: %d -> decoded: %d\n", encoded_inst.reg0, decoded_inst.reg0);
        fprintf(stdout, "[error] (invalid reg0) encoded: %d -> decoded: %d\n", encoded_inst.reg0, decoded_inst.reg0);
    }
    else if (asm_error == Asm_Reg1Err) {
        fprintf(fpdebug, "[error] (invalid reg1) encoded: %d -> decoded: %d\n", encoded_inst.reg1, decoded_inst.reg1);
        fprintf(stdout, "[error] (invalid reg1) encoded: %d -> decoded: %d\n", encoded_inst.reg1, decoded_inst.reg1);
    }
    else if (asm_error == Asm_Reg2Err) {
        fprintf(fpdebug, "[error] (invalid reg2) encoded: %d -> decoded: %d\n", encoded_inst.reg2, decoded_inst.reg2);
        fprintf(stdout, "[error] (invalid reg2) encoded: %d -> decoded: %d\n", encoded_inst.reg2, decoded_inst.reg2);
    }
    else if (asm_error == Asm_ImmErr) {
        fprintf(fpdebug, "[error] (invalid imm) encoded: %d -> decoded: %d\n", encoded_inst.imm, decoded_inst.imm);
        fprintf(stdout, "[error] (invalid imm) encoded: %d -> decoded: %d\n", encoded_inst.imm, decoded_inst.imm);
    }
    else if (asm_error == Asm_FimmErr) {
        fprintf(fpdebug, "[error] (invalid fimm) encoded: %f -> encoded: %f\n", encoded_inst.fimm, decoded_inst.fimm);
        fprintf(stdout, "[error] (invalid fimm) encoded: %f -> encoded: %f\n", encoded_inst.fimm, decoded_inst.fimm);
    }
    else if (asm_error == Asm_EncErr) {
        fprintf(fpdebug, "[error] (Encoding Error)");
        fprintf(stdout, "[error] (Encoding Error)");
    }
    else if (asm_error == Asm_Unknown) {
        fprintf(fpdebug, "[error] (Unknown)");
        fprintf(stdout, "[error] (Unknown)");
    }
    if (asm_error != Asm_OK) {
        exit(1);
    }
}