#pragma once

#define DEBUG

#include <vector>
#include <string>
#include <map>
#include <algorithm>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <filesystem>

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

        void read_line(FILE *);
        void read_operand(std::string, int &, Instruction &);
        int read_float(std::string);
        Instruction read_instruction(FILE *, bool);

        std::vector<std::string> input_files;
        std::string current_file;

        int sld_datacnt;

    public:
        bool statsflag;
        bool debugflag;
        Program() {
            line = 0;
            pc = 0;
            instructions = {};
            input_files = {};

            labels.clear();
            stats.clear();
        }
        void read_label();
        void read_program();
        void read_sld();
        void read_input(int, char const *[]);
        void print_debug();
        void print_stats();
        void exec();
        void assembler();
};

inline void Program::read_line(FILE *fp) {
    while(feof(fp) == 0) {
        int c = fgetc(fp);
        if (c == -1) continue;
        if (c == '\n') break;
    }
}

inline void Program::read_operand(std::string operand, int &regcnt, Instruction &inst) {
    if (operand[0] == 'x' || operand[0] == 'f') {
        // reg: x[0-9] || f[0-9]
        if (operand[1] >= '0' && operand[1] <= '9') {
            int reg = stoi(operand.substr(1));
            switch(regcnt) {
                case 0: inst.reg0 = reg; break;
                case 1: inst.reg1 = reg; break;
                case 2: inst.reg2 = reg; break;
            }
            regcnt++;
        }
        // label: reg: x, f 始まりで数字が続かない
        else {
            if (labels.count(operand) == 0) inst.imm = -4 - pc;
            else inst.imm = labels[operand] - pc;
        }
    }
    // imm: [0-9, -] 始まり
    else if ((operand[0] >= '0' && operand[0] <= '9') || operand[0] == '-') {
        inst.imm = stoi(operand.substr(0));
    }
    // %hi, %lo: % 始まり
    else if (operand[0] == '%') {
        if (labels.count(operand.substr(1)) == 0) inst.imm = -4;
        else inst.imm = labels[operand.substr(1)];
    }
    // label: その他
    else {
        if (labels.count(operand) == 0) inst.imm = -4 - pc; 
        else inst.imm = labels[operand] - pc;
    }
}

inline int Program::read_float(std::string operand) {
    union { float f; int i; } ftemp;
    ftemp.f = std::stof(operand);
    return ftemp.i;
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

    if (string_to_opcode.count(opcode) == 0) {
        std::cerr << "error: invalid opcode: " << opcode << std::endl;
        exit(1);
    }

    Opcode op = string_to_opcode[opcode];
    Instruction inst(line, op, brkp, current_file);
    
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
                        if (c == '\t') Program::read_line(fp);
                        inst.imm = Program::read_float(operand);
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
                        else if (c == '%') {
                            while(feof(fp) == 0) {
                                c = (char)fgetc(fp);
                                if ((int)c == -1) continue;
                                else if (c == '(') operand = "";
                                else if (c == ')') {
                                    Program::read_line(fp);
                                    flag = true;
                                    read_operand("%" + operand, regcnt, inst);
                                    break;
                                }
                                else operand += c;
                            }
                            break;
                        }
                        else if (c == '\n' || c == '\t' || c == ')') {
                            if (c == '\t' || c == ')') Program::read_line(fp);
                            flag = true;
                            read_operand(operand, regcnt, inst);
                            break;
                        }
                        else if (c == ' ' || c == '('){
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

    pc += 4;
    return inst;
}

inline void Program::read_label() {
    std::cout << "<<< label reading started..." << std::endl;

    pc = 4;
    for(auto fn: input_files) {
        if (fn.substr(fn.size() - 2) != ".s") continue;

        FILE *fp = fopen(fn.c_str(), "r");
        if (fp == NULL) {
            std::cerr << "error: an error occurred opening file.\n" << std::endl;
            exit(1);
        }
        
        std::string label = "";
        while(feof(fp) == 0) {
            char c = (char)fgetc(fp);
            if ((int)c == -1) {
                continue;
            }
            else if (c == '.') {
                Program::read_line(fp);
            }
            else if (c == '\t' || c == '*') {
                Program::read_line(fp);
                pc += 4;
            }   
            else {
                label = "";
                label += c;
                while(feof(fp) == 0) {
                    char c = (char)fgetc(fp);
                    if ((int)c == -1) continue;
                    else if (c == ':') {
                        Program::read_line(fp);
                        break;
                    }
                    label += c;
                }

                labels[label] = pc;
            }
        }
        fclose(fp);
    }

    std::cout << "label reading finished >>>\n" << std::endl;
}

inline void Program::read_program() {
    std::cout << "<<< program reading started..." << std::endl;

    Instruction entrypoint(0, Jal, false, "entrypoint");
    entrypoint.reg0 = 0;
    entrypoint.imm = labels["min_caml_start"];
    instructions.push_back(entrypoint);

    pc = 4;
    for(auto fn: input_files) {
        if (fn.substr(fn.size() - 2) != ".s") continue;

        FILE *fp = fopen(fn.c_str(), "r");
        if (fp == NULL) {
            std::cerr << "error: an error occurred opening file.\n" << std::endl;
            exit(1);
        }

        current_file = fn.substr(8);
        line = 0;
        while(feof(fp) == 0) {
            char c = fgetc(fp);
            if ((int)c == -1) {
                continue;
            }
            else if (c == '.') {
                line++;
                Program::read_line(fp);
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
                Program::read_line(fp);
            }
        }   
        fclose(fp);
    }
    
    std::cout << "program reading finished >>>\n" << std::endl;
}

inline void Program::read_sld() {
    std::cout << "<<< sld readin started\n" << std::endl;

    for(auto fn: input_files) {
        if (fn.substr(fn.size() - 2) == ".s") continue;

        FILE *fp = fopen(fn.c_str(), "r");
        if (fp == NULL) {
            std::cerr << "error: an error occurred opening file.\n" << std::endl;
            exit(1);
        }
        std::string num = "";
        int addr = instructions.size();
        sld_datacnt = 0;
        bool reading = false;
        while(feof(fp) == 0) {
            char c = fgetc(fp);
            if ((int)c == -1) {
                continue;
            }
            else if (c == '\n' || c == ' ') {
                if (reading) {
                    sld_datacnt++;
                    memory[addr] = read_float(num);

                    num = "";
                    addr++;
                }
                reading = false;
            }
            else {
                reading = true;
                num += c;
            }
        }
    }
    std::cout << "sld reading finished >>>\n" << std::endl;
}

inline void Program::read_input(int argc, char const *argv[]) {
    // input files
    std::string path = "./input";
    for(const auto &file: std::filesystem::directory_iterator(path)) {
        input_files.push_back(file.path());
    }
    std::cout << "<<< input files" << std::endl;
    for(auto fn: input_files) {
        std::cout << "\t" << fn << std::endl;
    }
    std::cout << std::endl;

    // options
    char statsoption[] = "--stats";
    char debugoption[] = "--debug";

    std::cout << "<<< runtime parameters:" << std::endl;
    std::cout << "\t--stats:\toutput runtime stats to ./output/stats.txt" << std::endl;
    std::cout << "\t--debug:\toutput parsed assembly to ./output/debug.txt\n" << std::endl;

    statsflag = false;
    debugflag = false;

    for(int i = 1; i < argc; i++) {
        if (strcmp(argv[i], statsoption) == 0) statsflag = true;
        else if (strcmp(argv[i], debugoption) == 0) debugflag = true; 
        else {
            std::cerr << "<<< runtime parameters are invalid" << std::endl;
            exit(1);
        }
    }

}

inline void Program::print_debug() {
    std::cout << "<<< debug started..." << std::endl;

    FILE *fp = fopen("./output/debug.txt", "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening file.\n" << std::endl;
        exit(1);
    }    

    int inst_num = (int)instructions.size();
    fprintf(fp, "<<< instruction counter: %d\n", inst_num);
    for(int i = 0; i < inst_num; i++) {
        Instruction tmp_inst = instructions[i];
        fprintf(fp, "\t%d:  \t", i*4);
        tmp_inst.print_debug(fp);
    }

    fprintf(fp, "\n<<< labels\n");
    for(auto i: labels) {
        fprintf(fp, "\t%s: %d\n", i.first.c_str(), i.second);
    }

    fprintf(fp, "\n<<< sld input: %d\n", sld_datacnt);
    for(int i = inst_num; i < inst_num + sld_datacnt; i++) {
        union { float f; int i; } tempf;
        tempf.i = memory[i];
        fprintf(fp, "\t%f\n", tempf.f);
    }

    fclose(fp);
    std::cout << "debug finished >>>\n" << std::endl;
}

inline void Program::print_stats() {
    std::cout << "<<< stats printing started..." << std::endl;

    FILE *fp = fopen("./output/stats.txt", "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening file.\n" << std::endl;
        exit(1);
    }    

    std::vector<std::pair<int, Opcode>> instr_counter;
    for(auto i: stats) {
        instr_counter.push_back({i.second, i.first});
    }
    std::sort(instr_counter.begin(), instr_counter.end(), std::greater<>());
    for(auto i: instr_counter) {
        fprintf(fp, "%s: \t%d\n", opcode_to_string[i.second].c_str(), i.first);
    }

    fclose(fp);
    std::cout << "stats printing finished >>>\n" << std::endl;
}

inline void Program::exec() {
    std::cout << "<<< program execution started..." << std::endl; 

    struct timespec start, end;

    clock_gettime(CLOCK_REALTIME, &start);

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

    clock_gettime(CLOCK_REALTIME, &end);

    std::cout << "\telapsed time: ";
    std::cout << (end.tv_sec + end.tv_nsec*1.0e-9) - (start.tv_sec + start.tv_nsec*1.0e-9) << std::endl;
    std::cout << "\tcounter: " << counter << '\n' << std::endl;

    int rownum = 8;
    int colnum = 32/rownum;
    for(int i = 0; i < rownum; i++) {
        std::cout << '\t';
        for(int j = 0; j < colnum; j++) {
            std::cout << "x" << i*colnum + j << "\t";
            std::cout << xregs[i*colnum + j] << ",\t";
        }
        std::cout << "\n";
    }
    std::cout << "\n";
    std::cout << "program finished >>>\n" << std::endl;
}

inline void Program::assembler() {
    std::cout << "<<< assembler started..." << std::endl;

    FILE *fp = fopen("./output/bin.txt", "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening file.\n" << std::endl;
        exit(1);
    }

    int n = instructions.size();
    for (int i = 0; i < n; i++) {
        instructions[i].assemble(fp, i);
    }

    fclose(fp);
    std::cout << "assembler finished >>>\n" << std::endl;
}
