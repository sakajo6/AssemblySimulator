/*
    sw, beqなどoffsetで代入する位置が異なるので注意
    即値をmachine codeに代入する際にunsigned intに変換して操作 <- 実装後、要確認

    x0のzero-regに対応。
        - 対応策としてはrdとなっているxdはx32とかで挿げ替える
*/


#include <stdio.h>
#include <fstream>

#include "sim_program.hpp"

using namespace std;

int main(int argc, char const *argv[]) {
    Program program;
    // check runtime param
    program.read_input(argc, argv);

    // init resources
    xregs[2] = 1024;

    // read label
    program.read_label();

    // read assembly
    program.read_program();

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