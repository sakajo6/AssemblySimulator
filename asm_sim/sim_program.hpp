#pragma once

#define DEBUG

#include <vector>
#include <string>
#include <map>
#include <algorithm>
#include <string.h>
#include <stdlib.h>

#include "sim_instruction.hpp"
#include "sim_opecode.hpp"
#include "sim_global.hpp"


extern const int memory_size;
extern int memory[memory_size];
extern const int xregs_size;
extern int xregs[xregs_size];
extern const int fregs_size;
extern float fregs[fregs_size];

class Program {
    private:
        int line;
        int pc;
        std::vector<Instruction> instructions;

        std::map<std::string, int> labels;
        std::map<Opcode, int> stats; 

        Instruction read_instruction_0(Opcode op, FILE *fp, bool brkp);
        Instruction read_instruction_1(Opcode op, FILE *fp, bool brkp);
        Instruction read_instruction_2(Opcode op, FILE *fp, bool brkp);
        Instruction read_instruction_3(Opcode op, FILE *fp, bool brkp);
        Instruction read_instruction_4(Opcode op, FILE *fp, bool brkp);
        Instruction read_instruction_5(Opcode op, FILE *fp, bool brkp);
        Instruction read_instruction_6(Opcode op, FILE *fp, bool brkp);

        Instruction read_instruction(FILE *fp, bool brkp);

        void getline(FILE *fp);

    public:
        bool asmflag;
        bool statsflag;
        bool debugflag;
        Program() {
            line = 0;
            pc = 0;
            instructions = {};

            labels.clear();
            stats.clear();
        }
        void read_program(FILE *fp);
        void read_label(FILE *fp);
        void print_debug(FILE *fp);
        long long int exec();
        void assembler(FILE *fp);
        void print_stats(FILE *fp);
        void readinput(int argc, char const *argv[]);
};


// opcode r, r, r
inline Instruction Program::read_instruction_0(Opcode op, FILE *fp, bool brkp) {
    int operands[3];
    int operand_cnt = 0;

    std::string operand = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        else if (c == '\t') continue;
        else if (c < ' ' || c == '#') {
            // line ends;
            operands[operand_cnt] = stoi(operand.substr(1));
            if (c != '\n') Program::getline(fp);
            break;
        }
        switch(c) {
            case ' ': 
                break;
            case ',':
                operands[operand_cnt] = stoi(operand.substr(1));
                operand = "";
                operand_cnt++;
                break;
            default:
                operand += c;
                break;
        }
    }

    return Instruction(line, op, operands[0], operands[1], operands[2], -1, brkp);
}

// opcode r, r, imm
inline Instruction Program::read_instruction_1(Opcode op, FILE *fp, bool brkp) {
    int operands[3];
    int operand_cnt = 0;

    std::string operand = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        else if (c == '\t') continue;
        else if (c < ' ' || c == '#') {
            // line ends;
            operands[operand_cnt] = stoi(operand.substr(0));
            if (c != '\n') Program::getline(fp);
            break;
        }
        switch(c) {
            case ' ': break;
            case ',':
                operands[operand_cnt] = stoi(operand.substr(1));
                operand = "";
                operand_cnt++;
                break;
            default:
                operand += c;
                break;
        }
    }

    return Instruction(line, op, operands[0], operands[1], -1, operands[2], brkp);
}

// opcode r, imm(r)
inline Instruction Program::read_instruction_2(Opcode op, FILE *fp, bool brkp) {
    int operands[3];
    int operand_cnt = 0;

    std::string operand = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        else if (c == '\t') continue; 
        else if (c == ')') {
            // line ends;
            operands[operand_cnt] = stoi(operand.substr(1));
            if (c != '\n') Program::getline(fp);
            break;
        }
        switch(c) {
            case ' ': break;
            case ',':
                operands[operand_cnt] = stoi(operand.substr(1));
                operand = "";
                operand_cnt++;
                break;
            case '(':
                operands[operand_cnt] = stoi(operand.substr(0));
                operand = "";
                operand_cnt++;
                break;
            default:
                operand += c;
                break;
        }
    }

    return Instruction(line, op, operands[0], operands[2], -1, operands[1], brkp);
}

// opcode r, r, label
inline Instruction Program::read_instruction_3(Opcode op, FILE *fp, bool brkp) {
    int operands[3];
    int operand_cnt = 0;

    std::string operand = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        else if (c == '\t') continue;
        else if (c < ' ' || c == '#') {
            // line ends;
            operands[operand_cnt] = labels[operand] - pc;
            if (c != '\n') Program::getline(fp);
            break;
        }
        switch(c) {
            case ' ': break;
            case ',':
                operands[operand_cnt] = stoi(operand.substr(1));
                operand = "";
                operand_cnt++;
                break;
            default:
                operand += c;
                break;
        }
    }

    return Instruction(line, op, operands[0], operands[1], -1, operands[2], brkp);
}

// opcode r, label
inline Instruction Program::read_instruction_4(Opcode op, FILE *fp, bool brkp) {
    int operands[2];
    int operand_cnt = 0;

    std::string operand = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        else if (c == '\t') continue;
        else if (c < ' ' || c == '#') {
            // line ends;
            operands[operand_cnt] = labels[operand] - pc;
            if (c != '\n') Program::getline(fp);
            break;
        }
        switch(c) {
            case ' ': break;
            case ',':
                operands[operand_cnt] = stoi(operand.substr(1));
                operand = "";
                operand_cnt++;
                break;
            default:
                operand += c;
                break;
        }
    }

    return Instruction(line, op, operands[0], -1, -1, operands[1], brkp);
}

// opcode r, r
inline Instruction Program::read_instruction_5(Opcode op, FILE *fp, bool brkp) {
    int operands[2];
    int operand_cnt = 0;

    std::string operand = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        else if (c == '\t') continue;
        else if (c < ' ' || c == '#') {
            // line ends;
            operands[operand_cnt] = stoi(operand.substr(1));
            if (c != '\n') Program::getline(fp);
            break;
        }
        switch(c) {
            case ' ': break;
            case ',':
                operands[operand_cnt] = stoi(operand.substr(1));
                operand = "";
                operand_cnt++;
                break;
            default:
                operand += c;
                break;
        }
    }
    return Instruction(line, op, operands[0], operands[1], -1, -1, brkp);
}

// opcode r, imm
inline Instruction Program::read_instruction_6(Opcode op, FILE *fp, bool brkp) {
    int operands[2];
    int operand_cnt = 0;

    std::string operand = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        else if (c == '\t') continue;
        else if (c < ' ' || c == '#') {
            // line ends;
            operands[operand_cnt] = stoi(operand.substr(0));
            if (c != '\n') Program::getline(fp);
            break;
        }
        switch(c) {
            case ' ': break;
            case ',':
                operands[operand_cnt] = stoi(operand.substr(1));
                operand = "";
                operand_cnt++;
                break;
            default:
                operand += c;
                break;
        }
    }
    return Instruction(line, op, operands[0], -1, -1, operands[1], brkp);
}

inline Instruction Program::read_instruction(FILE *fp, bool brkp) {
    std::string opcode = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        if (c == '\t') break;
        opcode += c;
    }

    Instruction inst;


    if (string_to_opcode.count(opcode) == 0) {
        std::cerr << "error: invalid opcode." << std::endl;
        exit(1);
    }

    Opcode op = string_to_opcode[opcode];

    if (op < 100) inst = read_instruction_0(op, fp, brkp);
    else if (op < 200) inst = read_instruction_1(op, fp, brkp);
    else if (op < 300) inst = read_instruction_2(op, fp, brkp);
    else if (op < 400) inst = read_instruction_3(op, fp, brkp);
    else if (op < 500) inst = read_instruction_4(op, fp, brkp);
    else if (op < 600) inst = read_instruction_5(op, fp, brkp);
    else if (op < 700) inst = read_instruction_6(op, fp, brkp);
    else std::cerr << "error: unknown opcode." << std::endl;

    pc += 4;

    return inst;
}

inline void Program::getline(FILE *fp) {
    while(feof(fp) == 0) {
        int c = fgetc(fp);
        if (c == -1) continue;
        if (c == '\n') break;
    }
}

inline void Program::read_label(FILE *fp) {
    std::cout << "<<< label reading started..." << std::endl;

    pc = 0;
    while(feof(fp) == 0) {
        char c = fgetc(fp);
        if ((int)c == -1) {
            continue;
        }
        else if (c == '.') {
            Program::getline(fp);
        }
        else if (c == '\t' || c == '*') {
            Program::getline(fp);
            pc += 4;
        }   
        else {
            std::string label = "";
            label += c;
            while(feof(fp) == 0) {
                char c = (char)fgetc(fp);
                if ((int)c == -1) continue;
                else if (c == ':') {
                    Program::getline(fp);
                    break;
                }
                label += c;
            }

            labels[label] = pc;
        }
    }

    std::cout << "label reading finished >>>\n" << std::endl;
}

inline void Program::read_program(FILE *fp) {
    std::cout << "<<< program reading started..." << std::endl;

    line = 0;
    pc = 0;
    while(feof(fp) == 0) {
        char c = fgetc(fp);
        if ((int)c == -1) {
            continue;
        }
        else if (c == '.') {
            line++;
            Program::getline(fp);
        }
        else if (c == '\t') {
            line++;
            instructions.push_back(read_instruction(fp, false));
        }   
        else if (c == '*') {
            line++;
            fgetc(fp);
            instructions.push_back(read_instruction(fp, true));
        }
        else {
            line++;
            Program::getline(fp);
        }
    }    
    
    std::cout << "program reading finished >>>\n" << std::endl;
}

inline void Program::print_debug(FILE *fp) {
    std::cout << "<<< debug started..." << std::endl;
    int inst_num = (int)instructions.size();
    for(int i = 0; i < inst_num; i++) {
        Instruction tmp_inst = instructions[i];
        tmp_inst.print_debug(fp);
    }

    fprintf(fp, "\n");

    for(auto i: labels) {
        fprintf(fp, "%s %d\n", i.first.c_str(), i.second);
    }

    fprintf(fp, "\ninstruction num: %d\n", int(instructions.size()));
    std::cout << "debug finished >>>\n" << std::endl;
}

inline long long int Program::exec() {
    std::cout << "<<< program execution started..." << std::endl; 

    long long int counter = 0;

    pc = 0;
    while(pc != instructions.size()*4) {
        int prevpc = pc;
        if (statsflag) stats[instructions[pc/4].opcode]++;
        pc = instructions[pc/4].exec(pc);
        counter++;
        if(pc < 0) {
            std::cout << "error: pc became negative after line " << instructions[prevpc/4].line << std::endl;
            exit(1);
        }
    }

    std::cout << "program finished >>>\n" << std::endl;
    return counter;
}

inline void Program::print_stats(FILE *fp) {
    std::cout << "<<< stats printing started..." << std::endl;

    std::vector<std::pair<int, Opcode>> instr_counter;
    for(auto i: stats) {
        instr_counter.push_back({i.second, i.first});
    }
    std::sort(instr_counter.begin(), instr_counter.end(), std::greater<>());
    for(auto i: instr_counter) {
        fprintf(fp, "%s: \t%d\n", opcode_to_string[i.second].c_str(), i.first);
    }

    std::cout << "stats printing finished >>>\n" << std::endl;
}

inline void Program::assembler(FILE *fp) {
    std::cout << "<<< assembler started..." << std::endl;
    int n = instructions.size();
    for (int i = 0; i < n; i++) {
        instructions[i].assemble(fp, i);
    }
    std::cout << "assembler finished >>>\n" << std::endl;
}

inline void Program::readinput(int argc, char const *argv[]) {
    // options
    char asmoption[] = "--asm";
    char statsoption[] = "--stats";
    char debugoption[] = "--debug";

    std::cout << "<<< runtime parameters:" << std::endl;
    std::cout << "\t--asm:\t\toutput binary file to ./output/output.txt" << std::endl;
    std::cout << "\t--stats:\toutput runtime stats to ./output/stats.txt" << std::endl;
    std::cout << "\t--debug:\toutput parsed assembly to ./output/debug.txt\n" << std::endl;

    asmflag = false;
    statsflag = false;
    debugflag = false;

    for(int i = 2; i < argc; i++) {
        if (strcmp(argv[i], asmoption) == 0) asmflag = true;
        else if (strcmp(argv[i], statsoption) == 0) statsflag = true;
        else if (strcmp(argv[i], debugoption) == 0) debugflag = true; 
        else {
            std::cout << "<<< runtime parameters are invalid" << std::endl;
            exit(1);
        }
    }
}