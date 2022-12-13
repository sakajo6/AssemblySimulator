#pragma once

#include <vector>
#include <bitset>

class BranchPrediction {
    private: 
        int siz;
        int branchCnt;
        int branchHit;

        std::bitset<32> globalhistory;
        std::vector<int> BranchHistoryTable;
        std::vector<int> BranchTargetBuffer;

    public:
        BranchPrediction() {};
        BranchPrediction(int siz_) {
            siz = siz_;
            branchCnt = 0;
            branchHit = 0;

            globalhistory = std::bitset<32>(0);
            BranchHistoryTable.assign(1 << siz, 0);
            BranchTargetBuffer.assign(1 << siz, 0);
        };
        void printStats(FILE *);
        void branchUpdate(int, int);
};

inline void BranchPrediction::printStats(FILE *fp) {
    fprintf(fp, "\tBranch History Table size -> %d bit\n", (1 << siz) * 2);
    fprintf(fp, "\tBranch Target Buffer size -> %d byte\n", (1 << siz));

    fprintf(fp, "\tHit rate -> %lf\n", (double)branchHit/(double)branchCnt);
}

inline void BranchPrediction::branchUpdate(int pc_prev, int pc) {
    branchCnt++;
    
    int idx = ((std::bitset<32>(pc) >> 2) ^ globalhistory).to_ulong() % (1 << siz);

    // prediction
    int branchDest;
    int state = BranchHistoryTable[idx];
    if (state <= 1) branchDest = pc_prev + 4;
    else branchDest = BranchTargetBuffer[idx];

    // update
    // global history
    globalhistory = globalhistory << 1;
    if (pc_prev + 4 != pc) globalhistory ^= std::bitset<32>(1);

    // Branch History Table
    if (pc_prev + 4 == pc) {
        if (BranchHistoryTable[idx] > 0) BranchHistoryTable[idx]--;
    }
    else {
        if (BranchHistoryTable[idx] < 3) BranchHistoryTable[idx]++;
    }

    // Branch Target Buffer
    if (pc_prev + 4 != pc) BranchTargetBuffer[idx] = pc; 

    if (branchDest == pc) branchHit++; 
}