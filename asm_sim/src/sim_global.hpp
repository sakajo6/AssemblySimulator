#pragma once

#include <string>
#include <algorithm>

/*
    memory info:
        text section
        data section
        heap
        stack
*/
const int memory_size = 2048;
int memory[memory_size];

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
}