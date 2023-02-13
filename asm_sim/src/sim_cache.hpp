#pragma once

#include <iostream>
#include <vector>

#include "sim_opecode.hpp"

struct CacheLine {
    bool accessed;
    bool dirty;
    bool valid;
    unsigned int tag;
};

class Cache {
    private:
        long double clock;

        unsigned int tagSiz;
        unsigned int indexSiz;
        unsigned int offsetSiz;
        unsigned int waySiz;

        std::vector<CacheLine> cache;

        void updateAccessed(unsigned int, int);
        unsigned int pseudoLRU(unsigned int);

    public:
        bool prev_sw;
        unsigned int prev_sw_clock;

        unsigned int loadCnt;
        unsigned int loadHit;
        unsigned int storeCnt;
        unsigned int storeHit;

        Cache() {};
        Cache(unsigned int tag_, unsigned int index_, unsigned int offset_){
            clock = 0;

            // fix bit-size
            tagSiz = tag_;
            indexSiz = index_;
            offsetSiz = offset_;
            waySiz = 2;

            // cache body
            cache.assign((1 << indexSiz) * waySiz, CacheLine{false, false, false, 0});

            prev_sw = false;
            prev_sw_clock = 0;

            loadCnt = 0;
            loadHit = 0;
            storeCnt = 0;
            storeHit = 0;
        };  
        void cacheAccess(unsigned int, bool);
        long double get_clock();
        void printStats(FILE *);
};


inline void Cache::updateAccessed(unsigned int idx, int hit_way) {
    if (hit_way == 0) cache[idx].accessed = false;
    else cache[idx].accessed = true;
}

inline unsigned int Cache::pseudoLRU(unsigned int idx) {
    if (cache[idx].accessed) return 0;
    else return 1;
}

// flag: true -> load, false -> store
inline void Cache::cacheAccess(unsigned int pc, bool flag) {
    // 直前の命令がsw
    if (prev_sw) {
        clock += prev_sw_clock;
    }

    long double prev_clock = clock;

    unsigned int tag, index, offset;
    tag = pc >> (indexSiz + offsetSiz);
    index = (pc >> offsetSiz) % (1 << indexSiz);
    offset = pc % (1 << offsetSiz);

    index *= waySiz;
    
    // load
    if (flag) {
        loadCnt++;
        for(int i = 0; i < waySiz; i++) {
            CacheLine cacheline = cache[index + i];

            // hit
            if (cacheline.valid && tag == cacheline.tag) {
                loadHit++;

                // accessed: hitしたwayの値
                Cache::updateAccessed(index, i);

                // increment clock
                clock += 6;

                return;
            }
        }

        // miss
        unsigned int expway = Cache::pseudoLRU(index);

        // increment clock
        // expway上dirty_bit立ってたら9 clock
        if (cache[index + expway].dirty) {
            clock += 9;
        }
        // memory -> cacheへの書き込み
        clock += 40;
        // コアへのload
        clock += 4;

        // accessed, dirty, valid, tag
        // accessed: 反転, dirty: false
        cache[index + expway] = CacheLine{true, false, true, tag};

        Cache::updateAccessed(index, expway);
    }
    // store
    else {
        storeCnt++;
        for(int i = 0; i < waySiz; i++) {
            CacheLine cacheline = cache[index + i];

            // hit
            if (cacheline.valid && tag == cacheline.tag) {
                storeHit++;

                // accessed, dirty, valid, tag
                // accessed: hitしたwayの値, dirty: true
                cache[index + i] = CacheLine{false, true, true, tag};

                // increment clock
                clock += 0;

                // 直前にsw: hit -> 6 clock
                prev_sw_clock = 6;

                Cache::updateAccessed(index, i);
                return;
            }
        }

        // miss
        unsigned int expway = Cache::pseudoLRU(index);

        // increment clock
        // expway上dirty_bit立ってたら9 clock
        if (cache[index + expway].dirty) {
            clock += 9;
        }
        // memory -> cacheへの書き込み
        clock += 40;
        // コアへのload
        clock += 6;

        prev_sw_clock = clock - prev_clock;

        // accessed: 反転, dirty: true
        cache[index + expway] = CacheLine{false, true, true, tag};

        Cache::updateAccessed(index, expway);
    }

    return;
}

inline long double Cache::get_clock() {
    return clock;
}

inline void Cache::printStats(FILE *fp) {
    // size
    fprintf(fp, "\t\tCache size -> %d byte\n", (1 << indexSiz) * (1 << offsetSiz) * waySiz);

    // hit rate
    double hit = loadHit + storeHit;
    double total = loadCnt + storeCnt;
    fprintf(fp, "\t\tHit rate -> %lf\n", hit/total);
}