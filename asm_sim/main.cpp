/*
    sw, beqなどoffsetで代入する位置が異なるので注意
    即値をmachine codeに代入する際にunsigned intに変換して操作 <- 実装後、要確認

    x0のzero-regに対応。
        - 対応策としてはrdとなっているxdはx32とかで挿げ替える
*/


#include <stdio.h>
#include <iostream>
#include <fstream>
#include <iostream>
#include <time.h>

#include "sim_program.hpp"

using namespace std;

int main(int argc, char const *argv[]) {
    Program program;

    // init resources
    xregs[2] = 1024;

    // read label
    FILE *fp;
    fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "error: an error occurred opening file.\n");
        return 1;
    }
    std::cout << "<<< label read started...\n" << std::endl;
    program.read_label(fp);
    std::cout << "\n<<< label read ended\n" << std::endl;
    fclose(fp);

    // read assembly
    fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "error: an error occurred opening file.\n");
        return 1;
    }
    std::cout << "<<< program read started...\n" << std::endl;
    program.read_program(fp);
    std::cout << "\n<<< program read ended\n" << std::endl;
    fclose(fp);

    // exec assembler
    std::cout << "<<< assembler started\n" << std::endl;
    ofstream ofs("bin.txt");
    streambuf *oldrdbuf = cout.rdbuf(ofs.rdbuf());
    program.assembler();
    cout.rdbuf(oldrdbuf);
    std::cout << "<<< assembler ended\n" << std::endl;

    std::cout << "<<< execute simulator debug?[y/n]" << std::endl;
    char inputchar = getchar();
    if (inputchar == 'y') {
        std::cout << "<<< debug started\n" << std::endl;
        program.print_debug();
        std::cout << "\n<<< debug ended\n" << std::endl;
    }
    

    std::cout << "<<< output stats?[y/n]" << std::endl;
    // inputchar = getchar();
    bool statsflag = false;
    // if (inputchar == 'y') {
    //     statsflag = true;
    // }
    
    // exec assembly
	struct timespec start, end;
    
	clock_gettime(CLOCK_REALTIME, &start);
    std::cout << "<<< program executing\n" << std::endl;
    long long int counter = program.exec(statsflag);
    clock_gettime(CLOCK_REALTIME, &end);

    std::cout << "<<< program finished\n" << std::endl;
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
    if (statsflag) {
        ofstream ofs2("stats.txt");
        oldrdbuf = cout.rdbuf(ofs2.rdbuf());
        program.print_stats();
        cout.rdbuf(oldrdbuf);
    }

    return 0;
}