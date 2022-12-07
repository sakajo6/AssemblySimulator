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
        unsigned int tagSiz;
        unsigned int indexSiz;
        unsigned int offsetSiz;
        unsigned int waySiz;

        std::vector<CacheLine> cache;
        unsigned int loadCnt;
        unsigned int loadHit;
        unsigned int storeCnt;
        unsigned int storeHit;

        void updateAccessed(unsigned int idx);
        unsigned int pseudoLRU(unsigned int idx);

    public:
        Cache() {};
        Cache(unsigned int tag_, unsigned int index_, unsigned int offset_, unsigned int way_){
            // fix bit-size
            tagSiz = tag_;
            indexSiz = index_;
            offsetSiz = offset_;
            waySiz = way_;

            // cache body
            cache.assign((1 << indexSiz) * waySiz, CacheLine{false, false, false, 0});
            loadCnt = 0;
            loadHit = 0;
            storeCnt = 0;
            storeHit = 0;
        };  
        void cacheAccess(unsigned int, bool);
        double printHitRate();
};

inline void Cache::updateAccessed(unsigned int idx) {
    for(int i = 0; i < waySiz; i++) {
        if (!cache[idx + i].accessed) return;
    }
    for(int i = 0; i < waySiz; i++) {
        cache[idx + i].accessed = false;
    }
}

inline unsigned int Cache::pseudoLRU(unsigned int index) {
    for(int i = 0; i < waySiz; i++) {
        if (!cache[index + i].accessed) return index + i;
    }

    if (true) {
        std::cerr << "error: Cache::pseudoLRU()" << std::endl;
    }
    return 0;
}

inline void Cache::cacheAccess(unsigned int pc, bool flag) {
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
                cache[index + i].accessed = true;

                updateAccessed(index);

                return;
            }
        }

        // miss
        unsigned int expIndex = Cache::pseudoLRU(index);
        cache[expIndex] = CacheLine{true, false, true, tag};

        Cache::updateAccessed(index);
    }
    // store
    else {
        storeCnt++;
        for(int i = 0; i < waySiz; i++) {
            CacheLine cacheline = cache[index + i];

            // hit
            if (cacheline.valid && tag == cacheline.tag) {
                storeHit++;

                cache[index + i] = CacheLine{false, true, true, tag};
                return;
            }
        }

        // miss
        unsigned int expIndex = Cache::pseudoLRU(index);
        cache[expIndex] = CacheLine{false, true, true, tag};
    }

    return;
}

inline double Cache::printHitRate() {
    double hit = loadHit + storeHit;
    double total = loadCnt + storeCnt;
    return hit/total;
}
