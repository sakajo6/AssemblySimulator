#include <stdio.h>
#include <iostream>
#include <string>
#include <vector>

using namespace std;

struct Instruction {
    string opecode;
    int operand_cnt;
    string operands[4];

    // //constructor
    // Instruction() {

    // }

    // execute instruction
    int execute() {
        return 0;
    }
};


struct Label {
    string label;

    // //constructor
    // Label() {

    // }
};

struct Line {
    // flag: instruction -> 0, label -> 1
    bool flag;
    Instruction instruction;
    Label label;

    // //constructor
    // Line(bool f, Instruction instr, Label lab) {
    //     flag = f;
    //     instruction = instr;
    //     label = lab;
    // }
};


Instruction readInstruction(FILE *fp) {
    // read instruction
    Instruction ret;
    ret.operand_cnt = 0;

    // read opecode
    string opecode = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if (c == ' ') {
            break;
        }
        opecode += c;
    }
    ret.opecode = opecode;

    /*
        opcode x, y, z
        opcode x, y
        opcode x, y(z)
    */

    // read operand
    string operand = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) {
            continue;
        }
        else if (c == '\n') {
            break;
        }
        else if (c == ' ') {
            cerr << "don't put space in unnnecessary position." << endl;
            exit(1);
        }
        else if (c == ',') {
            if (operand != "") {
                ret.operands[ret.operand_cnt] = operand;
                ret.operand_cnt++;
                operand = "";
            }

            c = (char)fgetc(fp);
            if (c != ' ') {
                cerr << "space is needed after comma"<<endl;
                exit(1);
            }
            continue;
        }
        else if (c == '(') {
            if (operand != "") {           
                ret.operands[ret.operand_cnt] = operand;
                ret.operand_cnt++;
                operand = "";
            }

            continue;
        }
        else if (c == ')') {
            if (operand != "") {
                ret.operands[ret.operand_cnt] = operand;
                ret.operand_cnt++;
                operand = "";
            }

            continue;
        }
        else{
            operand += c;
        }
    }

    //error!!
    if (operand.size() != 0) {
        ret.operands[ret.operand_cnt] = operand;
        ret.operand_cnt++;
    }

    return ret;
}

Label readLabel(char c, FILE *fp) {
    // read label
    Label ret;

    return ret;
}


int memory[1024];
int regis[32]; 
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
        if ((char)c == ' ') {
            for (int i = 0; i < 3; i++) {
                fgetc(fp);
            }
            lines.push_back(Line{false, readInstruction(fp), Label{}});
        }   
        else {
            lines.push_back(Line{true, Instruction{}, readLabel((char)c, fp)});
        }
    }    

    int linenum = lines.size();
    for (int i = 0; i < linenum; i++) {
        Line tmp_line = lines[i];
        
        //label
        if (tmp_line.flag) {

        }
        //instruction
        else {
            Instruction tmp_inst = tmp_line.instruction;
            cout<<tmp_inst.operand_cnt<<endl;
            cerr<<tmp_inst.opecode<<endl;
            for (int j = 0; j < tmp_inst.operand_cnt; j++) {
                for (int k = 0; k < tmp_inst.operands[j].size(); k++) {
                    cout<<(int)tmp_inst.operands[j][k]<<" ";
                }
                cout<<endl;
            }
            cerr<<endl;
        }
    }

    return 0;
}