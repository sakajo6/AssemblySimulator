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

struct MemIndex {
    unsigned int tag;
    unsigned int index;
    unsigned int offset;
};

struct CacheWay {
    bool dirty;
    bool valid;
    unsigned int tag;
    std::vector<U> data;    // size: (1 << offsetSiz)/4
};

struct CacheLine {
    unsigned int accessed;
    std::vector<CacheWay> ways;
};

class Cache {
    private:
        // cache stats
        long double clocks;
        long double clocks_store_hit;
        long double clocks_store_miss;
        long double clocks_load_hit;
        long double clocks_load_miss;
        long int load_hit_cnt;
        long int load_miss_cnt;
        long int store_hit_cnt;
        long int store_miss_cnt;

        // cache info
        CacheType cacheType;
        unsigned int tagSiz;
        unsigned int indexSiz;
        unsigned int offsetSiz;
        unsigned int waySiz;

        // cache actual data
        std::vector<CacheLine> cache;

        void controlStoreStall();
        MemIndex splitAddress(unsigned int);
        void writeBack(unsigned int, unsigned int, unsigned int);

    public:
        // control store stall
        MemAccessResult result_last_sw;
        long double clocks_from_last_sw;
        long double clocks_last_sw;

        Cache() {};
        Cache(CacheType cacheType_, unsigned int tag_, unsigned int index_, unsigned int offset_, unsigned int way_){
            // cache stats
            clocks = 0;
            clocks_load_hit = 0;
            clocks_load_miss = 0;
            clocks_store_hit = 0;
            clocks_store_miss = 0;
            load_hit_cnt = 0;
            load_miss_cnt = 0;
            store_hit_cnt = 0;
            store_miss_cnt = 0;

            // cache info
            cacheType = cacheType_;
            tagSiz = tag_;
            indexSiz = index_;
            offsetSiz = offset_;
            waySiz = way_;

            // initialize cache body
            cache.assign(
                (1 << indexSiz), 
                CacheLine {
                    0,      // accessed
                    std::vector<CacheWay>(
                        waySiz,
                        CacheWay {
                            false,  // dirty
                            false,  // valid
                            0,      // tag
                            std::vector<U>((1 << offsetSiz)/4)
                        }
                    )
                });

            // control store stall
            result_last_sw = Miss;
            clocks_from_last_sw = 0;
            clocks_last_sw = 0;
        };

        // memory access handlers
        U Load(unsigned int);
        void Store(unsigned int, U);

        // stats handlers
        long double get_clock();
        void printStats(FILE *);
};

inline void Cache::controlStoreStall() {
    long double stall_for_last_sw = std::max((long double)0, clocks_last_sw - clocks_from_last_sw);
    switch(result_last_sw) {
        case Hit:   clocks_store_hit += stall_for_last_sw;
        case Miss:  clocks_store_miss += stall_for_last_sw;
    }
    clocks += stall_for_last_sw;

    clocks_from_last_sw = 0;
    clocks_last_sw = 0;
}

inline MemIndex Cache::splitAddress(unsigned int addr) {
    unsigned int tag, index, offset;
    tag = addr >> (indexSiz + offsetSiz);
    index = (addr >> offsetSiz) % (1 << indexSiz);
    offset = addr % (1 << offsetSiz);

    return MemIndex{tag, index, offset};
}

inline void Cache::writeBack(unsigned int exp_way, unsigned int tag, unsigned int index) {
    // compute address for write-back
    unsigned int write_back_addr = 0;
    write_back_addr += (tag << (indexSiz + offsetSiz));
    write_back_addr += (index << offsetSiz);

    for(int i = 0; i < (1 << offsetSiz)/4; i++) {
        memory[write_back_addr + 4*i] = cache[index].ways[exp_way].data[i];
    }
}

inline U Cache::Load(unsigned int addr) {
    MemIndex memIndex = splitAddress(addr);
    unsigned int tag = memIndex.tag;
    unsigned int index = memIndex.index;
    unsigned int offset = memIndex.offset;

    int hit_way = -1;
    MemAccessResult result = Miss;
    for(int w = 0; w < waySiz; w++) {
        CacheWay cacheWay = cache[index].ways[w];
        if (cacheWay.valid && tag == cacheWay.tag) {
            hit_way = w;
            result = Hit;
            break;
        }
    }
    
    U loaded_data;
    if (result == Hit) {
        // update stats
        load_hit_cnt++;
        if (cacheType == InstCache) {
            clocks += instCache_load_hit;
            clocks_load_hit += instCache_load_hit;
        }
        else if (cacheType == DataCache) {
            clocks += dataCache_load_hit;
            clocks_load_hit += dataCache_load_hit;
        }

        // update cache contents
        //      accessed -> <hit way>
        //          dirty    -> <as it is>
        //          valid    -> <as it is>
        //          tag      -> <as it is>
        //          data     -> <as it is>
        cache[index].accessed = hit_way;
        loaded_data = cache[index].ways[hit_way].data[offset/4];
    }
    else if (result == Miss) {
        // decide way to be kicked out
        unsigned int exp_way = 1 - cache[index].accessed;

        // update stats
        load_miss_cnt++;
        if (cacheType == InstCache)  {
            clocks += instCache_load_miss;
            clocks_load_miss += instCache_load_miss;
            if (cache[index].ways[exp_way].dirty) {
                clocks += instCache_load_miss_dirty;
                clocks_load_miss += instCache_load_miss_dirty;
            }
        }
        else if (cacheType == DataCache) {
            clocks += dataCache_load_miss;
            clocks_load_miss += dataCache_load_miss;
            if (cache[index].ways[exp_way].dirty) {
                clocks += dataCache_load_miss_dirty;
                clocks_load_miss += dataCache_load_miss_dirty;
            }
        }

        // dirty line -> to be written back to memory
        if (cache[index].ways[exp_way].dirty) {
            writeBack(exp_way, cache[index].ways[exp_way].tag, index);
        }

        // update cache contents:
        //      accessed -> <exp way>
        //          dirty    -> false
        //          valid    -> true
        //          tag      -> <update>
        //          data     -> <update>
        cache[index].accessed = exp_way;
        cache[index].ways[exp_way].dirty = false;
        cache[index].ways[exp_way].valid = true;
        cache[index].ways[exp_way].tag = tag;
        for(int i = 0; i < (1 << offsetSiz)/4; i++) {
            cache[index].ways[exp_way].data[i] = memory[(addr/(1 << offsetSiz))*(1 << offsetSiz) + 4*i];
        }

        // set return value
        loaded_data = cache[index].ways[exp_way].data[offset/4];
    }
    
    return loaded_data;
}

inline void Cache::Store(unsigned int addr, U stored_data) {
    MemIndex memIndex = splitAddress(addr);
    unsigned int tag = memIndex.tag;
    unsigned int index = memIndex.index;
    unsigned int offset = memIndex.offset;

    int hit_way = -1;
    MemAccessResult result = Miss;
    for(int w = 0; w < waySiz; w++) {
        CacheWay cacheWay = cache[index].ways[w];
        if (cacheWay.valid && tag == cacheWay.tag) {
            hit_way = w;
            result = Hit;
            break;
        }
    }

    if (result == Hit) {
        // update stats
        store_hit_cnt++;
        if (cacheType == InstCache) {
            clocks_last_sw += instCache_store_hit;
        }
        else if (cacheType == DataCache) {
            clocks_last_sw += dataCache_store_hit;
        }
        result_last_sw = Hit;

        // update cache contents
        //      accessed -> <hit way>
        //          dirty    -> true
        //          valid    -> true
        //          tag      -> <as it is>
        //          data     -> <update>
        cache[index].accessed = hit_way;
        cache[index].ways[hit_way].dirty = true;
        cache[index].ways[hit_way].valid = true;
        cache[index].ways[hit_way].data[offset/4] = stored_data;
    }
    else if (result == Miss) {
        // decide way to be kicked out
        unsigned int exp_way = 1 - cache[index].accessed;

        // update stats
        store_miss_cnt++;
        if (cacheType == InstCache) {
            clocks_last_sw += instCache_store_miss;
            if (cache[index].ways[exp_way].dirty) {
                clocks_last_sw += instCache_store_miss_dirty;
            }
        }
        else if (cacheType == DataCache) {
            clocks_last_sw += dataCache_store_miss;
            if (cache[index].ways[exp_way].dirty) {
                clocks_last_sw += dataCache_store_miss_dirty;
            }
        }
        result_last_sw = Miss;

        // dirty line -> to be written back to memory
        if (cache[index].ways[exp_way].dirty) {
            writeBack(exp_way, cache[index].ways[exp_way].tag, index);
        }

        // update cache contents:
        //      accessed -> <exp way>
        //          dirty    -> true
        //          valid    -> true
        //          tag      -> <update>
        //          data     -> <update>
        cache[index].accessed = exp_way;
        cache[index].ways[exp_way].dirty = true;
        cache[index].ways[exp_way].valid = true;
        cache[index].ways[exp_way].tag = tag;
        for(int i = 0; i < (1 << offsetSiz)/4; i++) {
            cache[index].ways[exp_way].data[i] = memory[(addr/(1 << offsetSiz))*(1 << offsetSiz) + 4*i];
        }
        cache[index].ways[exp_way].data[offset/4] = stored_data;
    }
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