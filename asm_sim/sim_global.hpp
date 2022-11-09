#pragma once

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