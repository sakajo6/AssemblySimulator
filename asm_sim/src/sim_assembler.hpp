#include <vector>

#include "sim_instruction.hpp"


class Assembler {
    public:
        void assemble(std::vector<Instruction> &);
};


inline void Assembler::assemble(std::vector<Instruction> &instructions) {
    std::cout << "<<< assembler started..." << std::endl;

    FILE *fp = fopen("./output/bin.txt", "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening ./output/bin.txt.\n" << std::endl;
        exit(1);
    }

    int n = instructions.size();
    for (int i = 0; i < n; i++) {
        instructions[i].assemble(fp, i*4, veriflag);
    }

    fclose(fp);
    std::cout << "<<< assembler finished\n" << std::endl;
}