#include <stdio.h>
#include <string>
#include <vector>

using namespace std;

struct Instruction {
    string opecode;

    string rd;
    string rs1;
    string rs2;

    int imm;
    int offset;

    //constructor
    Instruction() {

    }

    // execute instruction
    int execute() {
        return 0;
    }
};


struct Label {
    string label;

    //constructor
    Label() {

    }
};

struct Line {
    // flag: instruction -> 0, label -> 1
    bool flag;
    Instruction instruction;
    Label label;

    //constructor
    Line() {

    }
};


Instruction readInstruction(FILE *fp) {
    // read instruction
    Instruction ret;

    return ret;
}

Label readLabel(char c, FILE *fp) {
    // read label
    Label ret;

    return ret;
}

vector<Line> lines;
int main(int argc, char const *argv[]) {
    FILE *fp;
    fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "error: an error occurred opening file.\n");
        return 1;
    }

    lines.resize(0);

    while(feof(fp) == 0) {
        int c = fgetc(fp);
        if (c == ' ') {
            for (int i = 0; i < 3; i++) {
                fgetc(fp);
            }
            // lines.push_back(readInstruction(fp));
        }   
        else {
            // lines.push_back(readLabel(c, fp));
        }
    }    

    return 0;
}