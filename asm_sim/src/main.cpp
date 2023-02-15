#include <stdio.h>
#include <fstream>
#include <iomanip>

#include "program.hpp"

int main(int argc, char const *argv[]) {
    std::cout << std::fixed << std::setprecision(10);

    
    

    Program program;
    program.callReader(argc, argv);
    program.callAssembler();
    program.exec();

    return 0;
}