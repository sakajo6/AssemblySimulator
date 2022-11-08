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

        std::map<std::string, int> labels;
        std::map<Opcode, int> stats; 

        void read_operand(std::string, int &, Instruction &);
        void read_float(std::string, Instruction &);
        Instruction read_instruction(FILE *, bool);

        void readline(FILE *);

    public:
        std::vector<Instruction> instructions;
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
        void read_program(FILE *);
        void read_label(FILE *);
        void print_debug(FILE *);
        long long int exec();
        void assembler(FILE *);
        void print_stats(FILE *);
        void readinput(int, char const *[]);
};

inline void Program::read_operand(std::string operand, int &regcnt, Instruction &inst) {
    if (operand[0] == 'x' || operand[0] == 'f') {
        // reg
        if (operand[1] >= '0' && operand[1] <= '9') {
            int reg = stoi(operand.substr(1));
            switch(regcnt) {
                case 0: inst.reg0 = reg; break;
                case 1: inst.reg1 = reg; break;
                case 2: inst.reg2 = reg; break;
            }
            regcnt++;
        }
        // label
        else {
            inst.imm = labels[operand] - pc;
        }
    }
    // imm
    else if ((operand[0] >= '0' && operand[0] <= '9') || operand[0] == '-') {
        inst.imm = stoi(operand.substr(0));
    }
    // label
    else {
        inst.imm = labels[operand] - pc;
    }
}

inline void Program::read_float(std::string operand, Instruction &inst) {
    union { float f; int i; } ftemp;
    ftemp.f = std::stof(operand);
    inst.imm = ftemp.i;
}

inline Instruction Program::read_instruction(FILE *fp, bool brkp) {
    char c;

    std::string opcode = "";
    while(feof(fp) == 0) {
        c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        if (c == '\t') break;
        opcode += c;
    }

    std::cout << opcode << std::endl;
    if (string_to_opcode.count(opcode) == 0) {
        std::cerr << "error: invalid opcode." << std::endl;
        exit(1);
    }

    Opcode op = string_to_opcode[opcode];
    Instruction inst(line, op, brkp);
    
    if (op == Word) {
        while(feof(fp) == 0) {
            bool flag = false;
            c = (char)fgetc(fp);
            if ((int)c == -1) continue;
            else if (c == '\t') continue;
            else {
                std::string operand = "";
                operand += c;
                while(feof(fp) == 0) {
                    c = (char)fgetc(fp);
                    if ((int)c == -1) continue;
                    else if (c == '\n' || c == '\t') {
                        if (c == '\t') Program::readline(fp);
                        Program::read_float(operand, inst);
                        flag = true;
                        break;
                    }
                    else {
                        operand += c;
                    }
                }
            }
            if(flag) break;
        }
    }
    else {
        while(feof(fp) == 0) {
            c = (char)fgetc(fp);
            if ((int)c == -1) continue;
            else if (c == '\t') continue;
            else {
                // 終端記号(\t, \n)が出現するまではオペランドを読み続ける
                int regcnt = 0;
                std::string operand = "";
                operand += c;
                while (true) {
                    bool flag = false;
                    // '\t', '\n', ' ', '(', ')'がオペランドの区切り文字が出現したらnext operand
                    while(feof(fp) == 0) {
                        c = (char)fgetc(fp);
                        if ((int)c == -1) continue;
                        else if (c == '\n' || c == '\t' || c == ')') {
                            if (c == '\t' || c == ')') Program::readline(fp);
                            flag = true;
                            std::cout << operand << std::endl;
                            read_operand(operand, regcnt, inst);
                            break;
                        }
                        else if (c == ' ' || c == '('){
                            std::cout << operand << " ";
                            read_operand(operand, regcnt, inst);
                            break;
                        }
                        else {
                            operand += c;
                        }
                    }
                    if (flag) break;
                    operand = "";
                }
                break;
            }
        }
    }

    inst.print_debug(stdout);
    pc += 4;
    return inst;
}

inline void Program::readline(FILE *fp) {
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
        char c = (char)fgetc(fp);
        if ((int)c == -1) {
            continue;
        }
        else if (c == '.') {
            Program::readline(fp);
        }
        else if (c == '\t' || c == '*') {
            Program::readline(fp);
            pc += 4;
        }   
        else {
            std::string label = "";
            label += c;
            while(feof(fp) == 0) {
                char c = (char)fgetc(fp);
                if ((int)c == -1) continue;
                else if (c == ':') {
                    Program::readline(fp);
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
            Program::readline(fp);
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
            Program::readline(fp);
        }
    }    
    
    std::cout << "program reading finished >>>\n" << std::endl;
}

inline void Program::print_debug(FILE *fp) {
    std::cout << "<<< debug started..." << std::endl;
    int inst_num = (int)instructions.size();
    fprintf(fp, "%d\n", inst_num);
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
            std::cerr << "error: pc became negative after line " << instructions[prevpc/4].line << std::endl;
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
            std::cerr << "<<< runtime parameters are invalid" << std::endl;
            exit(1);
        }
    }
}