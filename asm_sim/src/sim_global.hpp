#pragma once

#include <string>
#include <algorithm>
#include <bitset>

/*
    memory info:
        text section
        data section
        heap
        stack
*/
const int memory_size = 20000;
union U {
  int i;
  float f;
};
std::vector<U> memory(memory_size);

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
}