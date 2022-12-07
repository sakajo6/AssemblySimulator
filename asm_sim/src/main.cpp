#include <stdio.h>
#include <fstream>
#include <iomanip>

#include "sim_program.hpp"

void remove_files(){
    remove("./output/bin.txt");
    remove("./output/debug.txt");
    remove("./output/output.ppm");
    remove("./output/pcToFilepos.txt");
    remove("./output/stats.txt");
}
int main(int argc, char const *argv[]) {
    std::cout << std::fixed << std::setprecision(10);

    remove_files();

    Program program;
    program.callReader(argc, argv);
    program.callAssembler();
    program.exec();

    return 0;
}