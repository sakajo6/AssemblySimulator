#include <stdio.h>
#include <fstream>

#include "sim_program.hpp"

using namespace std;

int main(int argc, char const *argv[]) {
    Program program;
    // check runtime param
    program.read_input(argc, argv);
    
    // read label
    program.read_label();

    // read assembly
    program.read_program();

    // read sld
    program.read_sld();

    // exec assembler
    program.assembler();

    // exec simulator debug
    if (program.debugflag) {
        program.print_debug();
    }

    // exec assembly
    program.exec();

    // stats
    if (program.statsflag) {
        program.print_stats();
    }

    return 0;
}