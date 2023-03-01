#pragma once

#include <vector>
#include <bitset>

class BranchPrediction {
    private: 
        unsigned int BW;

        std::vector<unsigned int> BHT;
        std::vector<unsigned int> NAT;

        unsigned int bit(unsigned int, unsigned int, unsigned int);

    public:
        unsigned long long branchCnt;
        unsigned long long branchHit;

        BranchPrediction() {};
        BranchPrediction(unsigned int BW_) {
            BW = BW_;
            branchCnt = 0;
            branchHit = 0;

            BHT.assign(1 << BW, 0);
            NAT.assign(1 << BW, 0);
        };
        void printStats(FILE *);
        unsigned int predict(unsigned int);
        void update(unsigned int, unsigned int);

        long double get_clock();
};

inline unsigned int BranchPrediction::bit(unsigned int d, unsigned int m, unsigned int l) {
    unsigned int ret = d;
    ret <<= (31 - m);
    ret >>= (31 + l - m);

    return ret;
}

inline void BranchPrediction::printStats(FILE *fp) {
    fprintf(fp, "\tBranch History Table size -> %d bit\n", (1 << BW) * 2);
    fprintf(fp, "\tBranch Target Buffer size -> %d byte\n", (1 << BW));

    fprintf(fp, "\tHit rate -> %lf\n", (double)branchHit/(double)branchCnt);
}

inline unsigned int BranchPrediction::predict(unsigned int pc_F) {
    // culculate index
    unsigned int pc6F = bit(pc_F, 2 + BW - 1, 2);
    
    unsigned int BHT_out = BHT[pc6F];
    unsigned int NAT_out = NAT[pc6F];

    int prediction = bit(BHT_out, 1, 1);
    int pc_predF = prediction ? NAT_out : (pc_F + 4);
    return pc_predF;
}

inline void BranchPrediction::update(unsigned int pc_E, unsigned int pc_succE) {
    branchCnt++;

    // set input
    int pc_srcE;
    if (pc_E + 4 == pc_succE) pc_srcE = 0;
    else pc_srcE = 1;

    // culculate index
    unsigned int pc6E = bit(pc_E, 2 + BW - 1, 2);

    // predict
    unsigned int BHT_out = BHT[pc6E];
    unsigned int NAT_out = NAT[pc6E];

    int prediction = bit(BHT_out, 1, 1);
    int pc_predE = prediction ? NAT_out : (pc_E + 4);

    if (pc_srcE) {
        BHT[pc6E] = (BHT[pc6E] == 3) ? 3 : (BHT[pc6E] + 1);
        NAT[pc6E] = pc_succE;
    }
    else {
        BHT[pc6E] = (BHT[pc6E] == 0) ? 0 : (BHT[pc6E] - 1);
    }

    if (pc_predE == pc_succE) branchHit++; 
}

inline long double BranchPrediction::get_clock() {
    return (long double)(branchCnt - branchHit) * branch_prediction_miss;
}