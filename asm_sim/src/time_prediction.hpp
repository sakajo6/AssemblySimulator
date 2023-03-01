#pragma once

#include "cache.hpp"
#include "branch_prediction.hpp"

class TimePredict {
    private:
        long double clock;
        long double counter;

        Cache instCache;
        Cache dataCache;
        BranchPrediction branchPrediction;

        std::vector<long long int> stats;

    public:
        TimePredict() {};
        TimePredict(
            long double clock_,
            long double counter_,
            Cache *instCache_,
            Cache *dataCache_,
            BranchPrediction *branchPrediction_,
            std::vector<long long int> *stats_) {
                clock = clock_;
                counter = counter_;
                instCache = *instCache_;
                dataCache = *dataCache_;
                branchPrediction = *branchPrediction_;
                stats = *stats_;
        };
        long double predict();     
};

long double TimePredict::predict() {
    // 1命令に何clockか確認
    long double clock_cnt = counter * 5;

    // # server.py 
    // - プログラム読み込み待ち
    // - {.binの行数} * 32 bit/line * 10000 clock/bit
    //      - 10000 clock/bit -> 80 clock/bitまで理論上可能
    //      - 定数になる

    // # server.py
    // - データ読み込み待ち
    // - 1300 byte * 8 bit/byte * 10000 clock/bit
    //      - 10000 clock/bit -> 80 clock/bitまで理論上可能

    // # 分岐ミス
    // - 2 clock
    clock_cnt = branchPrediction.get_clock();

    // # io out
    // - 65 byte目でstallし始める
    //      - 10000 clock/bit -> 80 clock/bitまで理論上可能

    //  # inst cache
    //  ## load
    //      ### hit:
    //          - 2 clock
    //      ### miss:
    //          - 45 clock (50 MHz)
    //  ## store
    //      ### hit:
    //          - 7 clock
    //      ### miss:
    //          - 50 clock (50 MHz)
    //  # inst cache
    //  ## load
    //      ### hit:
    //          - 2 clock
    //      ### miss:
    //          - 45 clock  (50 MHz)
    //          - 4 clock   (if dirty)
    //  ## store
    //      ### hit:
    //          - 3 clock
    //      ### miss:
    //          - 45 clock  (50 MHz)
    //          - 4 clock   (if dirty)
    clock_cnt += instCache.get_clock();
    clock_cnt += dataCache.get_clock();

    // FPU
    clock_cnt += stats[Fadd] * fadd_clock;   // fadd: 2 clock
    clock_cnt += stats[Fsub] * fsub_clock;   // fsub: 2 clock
    clock_cnt += stats[Fmul] * fmul_clock;   // fmul: 3 clock
    clock_cnt += stats[Fdiv] * fdiv_clock;   // fdiv: 9 clock
    clock_cnt += stats[Fsqrt] * fsqrt_clock;  // fsqrt: 6 clock

    return clock_cnt / clock;
}
