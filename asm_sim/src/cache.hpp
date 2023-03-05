#pragma once

#include <iostream>
#include <vector>

#include "opecode.hpp"

enum CacheType {
    InstCache,
    DataCache,
};

enum AccessType {
    Load,
    Store,
};

enum MemAccessResult {
    Hit,
    Miss,
};

struct CacheLine {
    bool accessed;
    bool dirty;
    bool valid;
    unsigned int tag;
};

class Cache {
    private:
        long double clocks;
        long double clocks_store_hit;
        long double clocks_store_miss;
        long double clocks_load_hit;
        long double clocks_load_miss;

        CacheType cacheType;
        unsigned int tagSiz;
        unsigned int indexSiz;
        unsigned int offsetSiz;
        unsigned int waySiz;

        std::vector<CacheLine> cache;

        void updateAccessed(unsigned int, int);
        unsigned int pseudoLRU(unsigned int);

    public:
        long int load_hit_cnt;
        long int load_miss_cnt;
        long int store_hit_cnt;
        long int store_miss_cnt;
        
        MemAccessResult result_last_sw;
        long double clocks_from_last_sw;
        long double clocks_last_sw;

        Cache() {};
        Cache(CacheType cacheType_, unsigned int tag_, unsigned int index_, unsigned int offset_, unsigned int way_){
            clocks = 0;
            clocks_load_hit = 0;
            clocks_load_miss = 0;
            clocks_store_hit = 0;
            clocks_store_miss = 0;

            cacheType = cacheType_;

            // fix bit-size
            tagSiz = tag_;
            indexSiz = index_;
            offsetSiz = offset_;
            waySiz = way_;

            // cache body
            cache.assign((1 << indexSiz) * waySiz, CacheLine{false, false, false, 0});

            load_hit_cnt = 0;
            load_miss_cnt = 0;
            store_hit_cnt = 0;
            store_miss_cnt = 0;

            clocks_from_last_sw = 0;
            clocks_last_sw = 0;
        };  
        void cacheAccess(unsigned int, AccessType);
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

inline void Cache::cacheAccess(unsigned int pc, AccessType accessType) {
    long double stall_for_last_sw = std::max((long double)0, clocks_last_sw - clocks_from_last_sw);
    switch(result_last_sw) {
        case Hit:   clocks_store_hit += stall_for_last_sw;
        case Miss:  clocks_store_miss += stall_for_last_sw;
    }
    clocks += stall_for_last_sw;

    clocks_from_last_sw = 0;
    clocks_last_sw = 0;

    long double prev_clock = clocks;

    unsigned int tag, index, offset;
    tag = pc >> (indexSiz + offsetSiz);
    index = (pc >> offsetSiz) % (1 << indexSiz);
    offset = pc % (1 << offsetSiz);

    index *= waySiz;

    // load
    switch(accessType) {
        case Load: {
            int hit_way = -1;
            MemAccessResult result = Miss;
            for(int i = 0; i < waySiz; i++) {
                CacheLine cacheline = cache[index + i];
                if (cacheline.valid && tag == cacheline.tag) {
                    hit_way = i;
                    result = Hit;
                    break;
                }
            }

            if (result == Hit) {
                load_hit_cnt++;

                // accessed: hitしたwayの値
                Cache::updateAccessed(index, hit_way);

                // increment clocks
                if (cacheType == InstCache) {
                    clocks += instCache_load_hit;
                    clocks_load_hit += instCache_load_hit;
                }
                else if (cacheType == DataCache) {
                    clocks += dataCache_load_hit;
                    clocks_load_hit += dataCache_load_hit;
                }
            }
            else if (result == Miss) {
                load_miss_cnt++;
                unsigned int expway = Cache::pseudoLRU(index);

                // increment clocks
                if (cacheType == InstCache)  {
                    clocks += instCache_load_miss;
                    clocks_load_miss += instCache_load_miss;
                    if (cache[index + expway].dirty) {
                        clocks += instCache_load_miss_dirty;
                        clocks_load_miss += instCache_load_miss_dirty;
                    }
                }
                else if (cacheType == DataCache) {
                    clocks += dataCache_load_miss;
                    clocks_load_miss += dataCache_load_miss;
                    if (cache[index + expway].dirty) {
                        clocks += dataCache_load_miss_dirty;
                        clocks_load_miss += dataCache_load_miss_dirty;
                    }
                }

                // accessed: reversed, dirty: false
                cache[index + expway] = CacheLine{true, false, true, tag};

                Cache::updateAccessed(index, expway);
            }

            break;
        }
        case Store: {
            int hit_way = -1;
            MemAccessResult result = Miss;
            for(int i = 0; i < waySiz; i++) {
                CacheLine cacheline = cache[index + i];
                if (cacheline.valid && tag == cacheline.tag) {
                    hit_way = i;
                    result = Hit;
                    break;
                }
            }

            if (result == Hit) {
                store_hit_cnt++;

                // accessed: hitしたwayの値, dirty: true
                cache[index + hit_way] = CacheLine{false, true, true, tag};

                // increment clocks
                if (cacheType == InstCache) {
                    clocks_last_sw += instCache_store_hit;
                }
                else if (cacheType == DataCache) {
                    clocks_last_sw += dataCache_store_hit;
                }

                result_last_sw = Hit;

                Cache::updateAccessed(index, hit_way);
            }
            else if (result == Miss) {
                store_miss_cnt++;
                unsigned int expway = Cache::pseudoLRU(index);

                // increment clocks
                if (cacheType == InstCache) {
                    clocks_last_sw += instCache_store_miss;
                    if (cache[index + expway].dirty) {
                        clocks_last_sw += instCache_store_miss_dirty;
                    }
                }
                else if (cacheType == DataCache) {
                    clocks_last_sw += dataCache_store_miss;
                    if (cache[index + expway].dirty) {
                        clocks_last_sw += dataCache_store_miss_dirty;
                    }
                }

                result_last_sw = Miss;

                // accessed: reversed, dirty: true
                cache[index + expway] = CacheLine{false, true, true, tag};

                Cache::updateAccessed(index, expway);
            }
        }
    }

    return;
}

inline long double Cache::get_clock() {
    return clocks;
}

inline void Cache::printStats(FILE *fp) {
    // size
    fprintf(fp, "\t\tCache size -> %d byte\n", (1 << indexSiz) * (1 << offsetSiz) * waySiz);

    // hit rate
    long double hit = load_hit_cnt + store_hit_cnt;
    long double total = (load_hit_cnt + load_miss_cnt) + (store_hit_cnt + store_miss_cnt);
    fprintf(fp, "\t\tLoad access -> %ld\n", load_hit_cnt + load_miss_cnt);
    fprintf(fp, "\t\t\t- Hit:\t%ld(%Lf s)\n", load_hit_cnt, (long double)clocks_load_hit/clock_cycle);
    fprintf(fp, "\t\t\t- Miss:\t%ld(%Lf s)\n", load_miss_cnt, (long double)clocks_load_miss/clock_cycle);
    fprintf(fp, "\t\tStore access -> %ld\n", store_hit_cnt + store_miss_cnt);
    fprintf(fp, "\t\t\t- Hit:\t%ld(%Lf s)\n", store_hit_cnt, (long double)clocks_store_hit/clock_cycle);
    fprintf(fp, "\t\t\t- Miss:\t%ld(%Lf s)\n", store_miss_cnt, (long double)clocks_store_miss/clock_cycle);
    fprintf(fp, "\t\tHit rate -> %Lf\n", hit/total);
}