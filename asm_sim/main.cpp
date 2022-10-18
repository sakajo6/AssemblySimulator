/*
    sw, beqなどoffsetで代入する位置が異なるので注意
    即値をmachine codeに代入する際にunsigned intに変換して操作 <- 実装後、要確認
    add
    addi
    sw
    lw
    addi
    blt
    jal
    label, immまとめる
*/


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
    program.read_label(fp);
    fclose(fp);

    fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "error: an error occurred opening file.\n");
        return 1;
    }

    program.read_program(fp);
    fclose(fp);

    program.print_debug();

    // assembler
    fp = fopen("bin.txt", "w");
    if (fp == NULL) {
        fprintf(stderr, "error: an error occurred opening file.\n");
    }
    program.assembler(fp);
    fclose(fp);
    
    // exec assembly
    program.exec();


    return 0;
}