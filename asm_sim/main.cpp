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

    
    // std::cout << "<<< debug started\n" << std::endl;
    // program.print_debug();
    // std::cout << "\n<<< debug ended\n" << std::endl;
    
    // exec assembler
    std::cout << "<<< assembler started\n" << std::endl;
    ofstream ofs("bin.txt");
    streambuf *oldrdbuf = cout.rdbuf(ofs.rdbuf());
    program.assembler();
    cout.rdbuf(oldrdbuf);
    std::cout << "<<< assembler ended\n" << std::endl;
    
    // exec assembly
    program.exec();
    std::cout << "<<< program finished\n" << std::endl;
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


    return 0;
}