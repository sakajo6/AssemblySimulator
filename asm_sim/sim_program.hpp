#pragma once

#define DEBUG

#ifdef DEBUG
#define DEBUG_PRINTF printf
#else
#define DEBUG_PRINTF (void)0:printf
#endif

#include <vector>
#include <string>
#include <map>

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

        std::map<std::string, Opcode> string_to_opcode = {
            // 0
            {"add", Add},
            {"sub", Sub},
            {"slt", Slt},

            {"mul", Mul},
            {"div", Div},

            {"fadd.s", Fadd_s},
            {"fsub.s", Fsub_s},
            {"fmul.s", Fmul_s},
            {"fdiv.s", Fdiv_s},
            {"feq.s", Feq_s},
            {"flt.s", Flt_s},

            // 1
            {"addi", Addi},
            {"ori", Ori},
            {"jalr", Jalr},

            // 2
            {"lw", Lw},
            {"sw", Sw},
            {"flw", Flw},
            {"fsw", Fsw},

            // 3
            {"beq", Beq},
            {"ble", Ble},
            {"bge", Bge},

            // 4
            {"jal", Jal},

            // 5
            {"fsqrt.s", Fsqrt_s},

            // 6
            {"lui", Lui},
        };

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
        Program() {
            line = 0;
            pc = 0;
            instructions = {};

            labels.clear();
        }
        void read_program(FILE *fp);
        void read_label(FILE *fp);
        void print_debug();
        void exec();
        void assembler();
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
            DEBUG_PRINTF("%s;\n", operand.c_str());
            operands[operand_cnt] = stoi(operand.substr(1));
            if (c != '\n') Program::getline(fp);
            break;
        }
        switch(c) {
            case ' ': 
                break;
            case ',':
                DEBUG_PRINTF("%s, ", operand.c_str());
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
            DEBUG_PRINTF("%s;\n", operand.c_str());
            operands[operand_cnt] = stoi(operand.substr(0));
            if (c != '\n') Program::getline(fp);
            break;
        }
        switch(c) {
            case ' ': break;
            case ',':
                DEBUG_PRINTF("%s, ", operand.c_str());
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
            DEBUG_PRINTF("%s;\n", operand.c_str());
            operands[operand_cnt] = stoi(operand.substr(1));
            if (c != '\n') Program::getline(fp);
            break;
        }
        switch(c) {
            case ' ': break;
            case ',':
                DEBUG_PRINTF("%s, ", operand.c_str());
                operands[operand_cnt] = stoi(operand.substr(1));
                operand = "";
                operand_cnt++;
                break;
            case '(':
                DEBUG_PRINTF("%s, ", operand.c_str());
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
            DEBUG_PRINTF("%s;\n", operand.c_str());
            operands[operand_cnt] = labels[operand] - pc;
            if (c != '\n') Program::getline(fp);
            break;
        }
        switch(c) {
            case ' ': break;
            case ',':
                DEBUG_PRINTF("%s, ", operand.c_str());
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
            DEBUG_PRINTF("%s;\n", operand.c_str());
            operands[operand_cnt] = labels[operand] - pc;
            if (c != '\n') Program::getline(fp);
            break;
        }
        switch(c) {
            case ' ': break;
            case ',':
                DEBUG_PRINTF("%s, ", operand.c_str());
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
            DEBUG_PRINTF("%s;\n", operand.c_str());
            operands[operand_cnt] = stoi(operand.substr(1));
            if (c != '\n') Program::getline(fp);
            break;
        }
        switch(c) {
            case ' ': break;
            case ',':
                DEBUG_PRINTF("%s, ", operand.c_str());
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
            DEBUG_PRINTF("%s;\n", operand.c_str());
            operands[operand_cnt] = stoi(operand.substr(0));
            if (c != '\n') Program::getline(fp);
            break;
        }
        switch(c) {
            case ' ': break;
            case ',':
                DEBUG_PRINTF("%s, ", operand.c_str());
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

    DEBUG_PRINTF("%s, ", opcode.c_str());

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

            DEBUG_PRINTF("%s,\n", label.c_str());   
        }
    }
}

inline void Program::read_program(FILE *fp) {
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
}

inline void Program::print_debug() {
    int inst_num = (int)instructions.size();
    for(int i = 0; i < inst_num; i++) {
        Instruction tmp_inst = instructions[i];
        tmp_inst.print_debug();
    }

    std::cout << std::endl;

    for(auto i: labels) {
        std::cout << i.first << " " << i.second << std::endl;
    }

    std::cout << std::endl;

    std::cout << instructions.size() << std::endl;
}

inline void Program::exec() {
    pc = labels["min_caml_start"];
    while(pc != instructions.size()*4) {
        int prevpc = pc;
        pc = instructions[pc/4].exec(pc);
        if(pc < 0) {
            std::cout << "error: pc became negative after line " << instructions[prevpc/4].line << std::endl;
            exit(1);
        }
    }
}

inline void Program::assembler() {
    int n = instructions.size();
    for (int i = 0; i < n; i++) {
        instructions[i].assemble(i);
    }
}