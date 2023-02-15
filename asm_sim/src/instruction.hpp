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

#include "opecode.hpp"

class Instruction {
    public:
        int line;
        Opcode opcode;
        bool breakpoint;
        int filenameIdx;

        int reg0, reg1, reg2;
        int imm;
        float fimm;

        #ifdef STATS
        bool luioriFlag;
        #endif

        Instruction() {}
        Instruction(int ln, Opcode opc, bool brkp, int idx) {
            line = ln;
            opcode = opc;
            breakpoint = brkp;
            filenameIdx = idx;

            reg0 = INT_MAX;
            reg1 = INT_MAX;
            reg2 = INT_MAX;
            imm = INT_MAX;
            fimm = FLT_MAX;

            #ifdef STATS
            luioriFlag = false;
            #endif
        }
};
