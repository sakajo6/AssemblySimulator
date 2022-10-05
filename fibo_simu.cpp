#include <stdio.h>
#include <string>
#include <vector>

using namespace std;

struct Instruction {
    // flag: 0 -> instruction, 1 -> label
    bool flag;    

    string label;

    string opecode;

    string rd;
    string rs1;
    string rs2;

    int imm;
    int offset;

    int execute() {
        return 0;
    }
};

vector<Instruction> instructions;

int main(int argc, char const *argv[]) {
    FILE *fp;
    fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "error: an error occurred opening file.\n");
        return 1;
    }

    while(feof(fp) == 0) {
        int c = fgetc(fp);
        if (c == -1) {
            break;
        }
        else {
            putchar(c);
        }

    }    

    return 0;
}