#pragma once

#include <vector>
#include <bitset>

class BranchPrediction {
    private: 
        int siz;
        unsigned long long branchCnt;
        unsigned long long branchHit;

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

// #pragma once

// #include <vector>
// #include <bitset>

// class BranchPrediction {
//     private: 
//         int GHR_length, BW;
//         unsigned long long branchCnt;
//         unsigned long long branchHit;

//         std::bitset<32> GHR;
//         std::vector<int> BHT;
//         std::vector<int> NAT;

//         unsigned int bit(unsigned int, unsigned int, unsigned int);

//     public:
//         BranchPrediction() {};
//         BranchPrediction(int GHR_length_, int BW_) {
//             GHR_length = GHR_length_;
//             BW = BW_;
//             branchCnt = 0;
//             branchHit = 0;

//             GHR = std::bitset<32>(0);
//             BHT.assign(1 << BW, 0);
//             NAT.assign(1 << BW, 0);
//         };
//         void printStats(FILE *);
//         int predict(int);
//         void update(int, int);
// };

// inline unsigned int bit(unsigned int d, unsigned int m, unsigned int l) {
//     unsigned int ret = d;
//     ret <<= (31 - m);
//     ret >>= (31 + l - m);

//     return ret;
// }

// inline void BranchPrediction::printStats(FILE *fp) {
//     fprintf(fp, "\tBranch History Table size -> %d bit\n", (1 << BW) * 2);
//     fprintf(fp, "\tBranch Target Buffer size -> %d byte\n", (1 << BW));

//     fprintf(fp, "\tHit rate -> %lf\n", (double)branchHit/(double)branchCnt);
// }

// inline void BranchPrediction::predict(int pc_F) {
    
// }

// // +4以外だとpc_srcEは1
// inline void BranchPrediction::update(int pc_E, int pc_succE) {
//     branchCnt++;

//     // set input
//     int pc_succE;
//     int pc_srcE;
//     if (pc_F == pc_E)
    
//     // culculate index
//     int idx = ((std::bitset<32>(pc_F) >> 2) ^ GHR).to_ulong() % (1 << BW);

//     // prediction
//     int state = BHT[idx];

//     int branchDest;
//     if (state <= 1) branchDest = pc_F + 4;   // untaken
//     else branchDest = NAT[idx];  // taken

//     // update
//     // global history
//     GHR = GHR << 1;
//     if (pc_F + 4 != pc_E) GHR ^= std::bitset<32>(1);

//     // Branch History Table
//     if (pc_F + 4 == pc_E) {
//         if (BHT[idx] > 0) BHT[idx]--;
//     }
//     else {
//         if (BHT[idx] < 3) BHT[idx]++;
//     }

//     // Branch Target Buffer
//     if (pc_F + 4 != pc_E) NAT[idx] = pc_E; 

//     if (branchDest == pc_E) branchHit++; 
// }