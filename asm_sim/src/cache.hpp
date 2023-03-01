#pragma once

#include <iostream>
#include <vector>

#include "opecode.hpp"

enum CacheType {
    InstCache,
    DataCache,
};

struct CacheLine {
    bool accessed;
    bool dirty;
    bool valid;
    unsigned int tag;
};

class Cache {
    private:
        long double clock;

        CacheType cacheType;
        unsigned int tagSiz;
        unsigned int indexSiz;
        unsigned int offsetSiz;
        unsigned int waySiz;

        std::vector<CacheLine> cache;

        void updateAccessed(unsigned int, int);
        unsigned int pseudoLRU(unsigned int);

    public:
        unsigned int loadCnt;
        unsigned int loadHit;
        unsigned int storeCnt;
        unsigned int storeHit;

        Cache() {};
        Cache(CacheType cacheType_, unsigned int tag_, unsigned int index_, unsigned int offset_, unsigned int way_){
            clock = 0;

            cacheType = cacheType_;

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
                if (cacheType == InstCache) {
                    clock += instCache_load_hit;
                }
                else if (cacheType == DataCache) {
                    clock += dataCache_load_hit;
                }

                return;
            }
        }

        // miss
        unsigned int expway = Cache::pseudoLRU(index);

        // increment clock
        if (cacheType == InstCache)  {
            clock += instCache_load_miss;
        }
        else if (cacheType == DataCache) {
            clock += dataCache_load_miss;
            if (cache[index + expway].dirty) {
                clock += dataCache_load_miss_dirty;
            }
        }

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
                if (cacheType == InstCache) {
                    clock += instCache_store_hit;
                }
                else if (cacheType == DataCache) {
                    clock += dataCache_store_hit;
                }

                Cache::updateAccessed(index, i);
                return;
            }
        }

        // miss
        unsigned int expway = Cache::pseudoLRU(index);

        // increment clock
        if (cacheType == InstCache) {
            clock += instCache_store_miss;
        }
        else if (cacheType == DataCache) {
            clock += dataCache_store_miss;
            if (cache[index + expway].dirty) {
                clock += dataCache_store_miss_dirty;
            }
        }

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