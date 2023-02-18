#pragma once

#include <vector>
#include <iostream>

#include "global.hpp"

class MemoryControl {
    private:
        std::vector<unsigned int> values;

    public:
        MemoryControl() {
            values.assign(memory_size, 0);
        }

        void update_last_store(unsigned int, unsigned int);
        unsigned int get_last_store(unsigned int);
};

inline void MemoryControl::update_last_store(unsigned int addr, unsigned int pc) {
    values.at(addr) = pc;
}

inline unsigned int MemoryControl::get_last_store(unsigned int addr) {
    return values.at(addr);
}