/*
    sw, beqなどoffsetで代入する位置が異なるので注意
    即値をmachine codeに代入する際にunsigned intに変換して操作 <- 実装後、要確認
*/


#include <stdio.h>
#include <iostream>
#include <fstream>
#include <iostream>

#include "sim_program.hpp"

using namespace std;

int main(int argc, char const *argv[]) {
    Program program;

    // read label
    FILE *fp;
    fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "error: an error occurred opening file.\n");
        return 1;
    }
    program.read_label(fp);
    fclose(fp);

    // read assembly
    fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "error: an error occurred opening file.\n");
        return 1;
    }
    program.read_program(fp);
    fclose(fp);

    
    //program.print_debug();
    ofstream ofs("bin.txt");
    streambuf *oldrdbuf = cout.rdbuf(ofs.rdbuf());
    program.assembler();
    cout.rdbuf(oldrdbuf);
    
    // exec assembly
    program.exec();


    return 0;
}