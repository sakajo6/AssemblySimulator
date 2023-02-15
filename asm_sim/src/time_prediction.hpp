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

    // # lw 
    // - 直前にsw
    //      - hit -> 6 clock
    //      - miss -> 直前のstoreにかかったclock
    // - 直前にlw
    //      - データが出るまでコアで待つ
    // ## hit:
    //  - 6 clock
    // ## miss:
    //  - dirty bit -> 9 clock
    //  - memoryからcacheへの書き込み -> 40 clock(50 MHz) (60 clock(100 MHz))
    //  - コアへのload -> 4 clock
    //
    // # sw
    // - 直前にsw
    //      - hit -> 6 clock
    //      - miss -> 直前のstoreにかかったclock
    // - 直前にlw
    //      - データが出るまでコアで待つ
    // ## hit
    //  - 0 clock
    // ## miss
    //  - dirty bit -> 9 clock
    //  - memoryからcacheへの書き込み -> 40 clock(50 MHz) (60 clock(100 MHz))
    //  - cacheへの書き込み -> 6 clock
    clock_cnt += instCache.get_clock();
    clock_cnt += dataCache.get_clock();

    // FPU
    clock_cnt += stats[Fadd] * 2.0;   // fadd: 2 clock
    clock_cnt += stats[Fsub] * 2.0;   // fsub: 2 clock
    clock_cnt += stats[Fmul] * 3.0;   // fmul: 3 clock
    clock_cnt += stats[Fdiv] * 9.0;   // fdiv: 9 clock
    clock_cnt += stats[Fsqrt] * 6.0;  // fsqrt: 6 clock
    clock_cnt += stats[Feq] * 2.0;    // feq: 2 clock
    clock_cnt += stats[Fle] * 2.0;    // fle: 2 clock

    return clock_cnt / clock;
}
