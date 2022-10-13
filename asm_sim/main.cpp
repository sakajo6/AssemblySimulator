#include <stdio.h>
#include <iostream>


#include "sim_program.hpp"

using namespace std;

int main(int argc, char const *argv[]) {
    FILE *fp;
    fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "error: an error occurred opening file.\n");
        return 1;
    }

    Program program;
    program.read_program(fp);

    // program.print_debug();

    program.exec();

    return 0;
}