#pragma once

#include <string>
#include <algorithm>
#include <bitset>
#include <fstream>

#include "instruction.hpp"

bool binflag;
bool brkallflag;
bool brknonflag;

std::ofstream output;
std::ofstream binary;

/*
    memory info:
        text section
        data section
        heap
        stack
*/
std::string path;
const int memory_size = (1 << 27); // アドレスなので実際のアドレスの4倍
int text_data_section = 0;
union U {
  unsigned int i;
  float f;
};
std::vector<U> memory(memory_size);
std::vector<U> std_input;

/*
    register info:
        x0: zero register
        x1: return address?

        x28: the size of program section
        x29: the number of read data by hardware
        x30: the number of read data by software
*/
const int xregs_size = 32;
int xregs[xregs_size];

const int fregs_size = 32;
float fregs[fregs_size];

namespace globalfun {
    void print_inst(FILE *fp, Instruction inst) {
        fprintf(fp, "%s ", opcode_to_string[inst.opcode].c_str());
        if (inst.reg0 != INT_MAX) fprintf(fp, "a%d ", inst.reg0);
        if (inst.reg1 != INT_MAX) fprintf(fp, "a%d ", inst.reg1);
        if (inst.reg2 != INT_MAX) fprintf(fp, "a%d ", inst.reg2);
        if (inst.imm != INT_MAX) fprintf(fp, "%d ", inst.imm);
        if (inst.fimm != FLT_MAX) fprintf(fp, "%f", inst.fimm);
    }

    void print_byte_hex(FILE *fp, unsigned int word) {
        unsigned int byte0, byte1, byte2, byte3;
        byte0 = (word >> 24) % (1 << 8);
        byte1 = (word >> 16) % (1 << 8);
        byte2 = (word >> 8) % (1 << 8);
        byte3 = (word >> 0) % (1 << 8);

        fprintf(fp, "%02x\n", byte0);
        fprintf(fp, "%02x\n", byte1);
        fprintf(fp, "%02x\n", byte2);
        fprintf(fp, "%02x\n", byte3);

        return;
    }

    std::string print_int(int x) {
        std::string retstr = "";

        int xtemp = std::abs(x);
        while(xtemp) {
            retstr += ('0' + xtemp%10);
            xtemp /= 10;
        }

        if (x < 0) retstr += '-';
        else if (x == 0) retstr += '0';
        else retstr += ' ';

        int n = (int) retstr.size();
        for(int i = 0; i < 11 - n; i++) {
            retstr += ' ';
        }
        std::reverse(retstr.begin(), retstr.end());
        return retstr;
    }
    
    std::string print_float(float f) {
        union { float f; int i; } tempf;
        tempf.f = f;
        return std::bitset<32>(tempf.i).to_string();
    }

    void print_regs(bool binflag) {
        int rownum = 8;
        int colnum = 32/rownum;
        if (binflag) {
            rownum = 16;
            colnum = 32/rownum;
        }
        for(int i = 0; i < rownum; i++) {
            std::cout << '\t';
            for(int j = 0; j < colnum; j++) {
                std::cout << "x" << i*colnum + j << ":\t";
                if (binflag) std::cout << std::bitset<32>(xregs[i*colnum + j]) << ",\t";
                else std::cout << globalfun::print_int(xregs[i*colnum + j]) << ",\t";
            }
            std::cout << "\n";
        }
        std::cout << "\n";
        for(int i = 0; i < rownum; i++) {
            std::cout << '\t';
            for(int j = 0; j < colnum; j++) {
                std::cout << "f" << i*colnum + j << ":\t";
                if (binflag) std::cout << globalfun::print_float(fregs[i*colnum + j]) << ",\t";
                else std::cout << fregs[i*colnum + j] << ",\t";
            }
            std::cout << "\n";
        }
        std::cout << "\n";
    }

    void print_binary_bin(int val, int bytes) {
        if (bytes == 1) {
            binary.write((const char*)&val, sizeof(char));
        }
        else if (bytes == 4) {
            std::string bit = std::bitset<32>(val).to_string();
            for (int i = 0; i < bytes; i++) {
                int byte = (int)std::bitset<8>(bit.substr(i * 8, 8)).to_ulong();
                binary.write((const char*)&byte, sizeof(char));    
            }
        }
    }

    void print_output_bin(int val, int bytes) {
        if (bytes == 1) {
            output.write((const char*)&val, sizeof(char));
        }
        else if (bytes == 4) {
            std::string bit = std::bitset<32>(val).to_string();
            for (int i = 0; i < bytes; i++) {
                int byte = (int)std::bitset<8>(bit.substr(i * 8, 8)).to_ulong();
                output.write((const char*)&byte, sizeof(char));    
            }
        }
    }
}