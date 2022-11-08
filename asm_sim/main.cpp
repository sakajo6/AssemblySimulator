/*
    sw, beqなどoffsetで代入する位置が異なるので注意
    即値をmachine codeに代入する際にunsigned intに変換して操作 <- 実装後、要確認

    x0のzero-regに対応。
        - 対応策としてはrdとなっているxdはx32とかで挿げ替える
*/


#include <stdio.h>
#include <fstream>
#include <time.h>

#include "sim_program.hpp"

using namespace std;

int main(int argc, char const *argv[]) {
    Program program;
    program.readinput(argc, argv);

    // init resources
    xregs[2] = 1024;

    // read label
    FILE *fp;
    fp = fopen(argv[1], "r");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening file.\n" << std::endl;
        return 1;
    }
    program.read_label(fp);
    fclose(fp);

    // read assembly
    fp = fopen(argv[1], "r");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening file.\n" << std::endl;
        return 1;
    }
    program.read_program(fp);
    fclose(fp);

    // exec assembler
    if (program.asmflag) {
        fp = fopen("./output/bin.txt", "w");
        if (fp == NULL) {
            std::cerr << "error: an error occurred opening file.\n" << std::endl;
            return 1;
        }
        program.assembler(fp);
    }

    // exec simulator debug
    if (program.debugflag) {
        fp = fopen("./output/debug.txt", "w");
        if (fp == NULL) {
            std::cerr << "error: an error occurred opening file.\n" << std::endl;
            return 1;
        }
        program.print_debug(fp);
    }

    // exec assembly
	struct timespec start, end;
    
	clock_gettime(CLOCK_REALTIME, &start);
    long long int counter = program.exec();
    clock_gettime(CLOCK_REALTIME, &end);

    std::cout << "\telapsed time: ";
    std::cout << (end.tv_sec + end.tv_nsec*1.0e-9) - (start.tv_sec + start.tv_nsec*1.0e-9) << std::endl;
    std::cout << "\tcounter: " << counter << '\n' << std::endl;

    int rownum = 8;
    int colnum = 32/rownum;
    for(int i = 0; i < rownum; i++) {
        std::cout << '\t';
        for(int j = 0; j < colnum; j++) {
            std::cout << "x" << i*colnum + j;
            if ((i*colnum + j)/10 == 0) std::cout << "  ";
            else std::cout << " ";
            std::cout << "0x" << std::hex << xregs[i*colnum + j] << std::dec << ",\t";
        }
        std::cout << "\n";
    }
    std::cout << "\n";

    // stats
    if (program.statsflag) {
        fp = fopen("./output/stats.txt", "w");
        if (fp == NULL) {
            std::cerr << "error: an error occurred opening file.\n" << std::endl;
            return 1;
        }
        program.print_stats(fp);
    }

    return 0;
}