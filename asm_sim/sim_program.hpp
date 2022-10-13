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
        int pc;
        std::vector<Instruction> instructions;

        int label_cnt;
        std::map<std::string, int> labels;
        std::vector<int> labels_address;

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

            // 2
            {"lw", Lw},
            {"sw", Sw},
            {"jalr", Jalr},
            {"flw", Flw},
            {"fsw", Fsw},

            // 3
            {"beq", Beq},
            {"blt", Blt},
            {"bge", Bge},

            // 4
            {"jal", Jal},

            // 5
            {"fsqrt.s", Fsqrt_s},
        };

        Instruction read_instruction_0(Opcode op, FILE *fp);
        Instruction read_instruction_1(Opcode op, FILE *fp);
        Instruction read_instruction_2(Opcode op, FILE *fp);
        Instruction read_instruction_3(Opcode op, FILE *fp);
        Instruction read_instruction_4(Opcode op, FILE *fp);
        Instruction read_instruction_5(Opcode op, FILE *fp);

        Instruction read_instruction(FILE *fp);

        void read_label(char c, FILE *fp);

        void getline(FILE *fp);

    public:
        Program() {
            pc = 0;
            instructions = {};

            label_cnt = 0;
            labels.clear();
            labels_address = {};
        }
        void read_program(FILE *fp);
        void print_debug();
        void exec();
};


// opcode r, r, r
inline Instruction Program::read_instruction_0(Opcode op, FILE *fp) {
    int operands[3];
    int operand_cnt = 0;

    std::string operand = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        else if (c < ' ' || c == '#') {
            // line ends;
            DEBUG_PRINTF("%s;\n", operand.c_str());
            operands[operand_cnt] = stoi(operand.substr(1));
            getline(fp);
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

    return Instruction(op, operands[0], operands[1], operands[2], -1, -1);
}

// opcode r, r, imm
inline Instruction Program::read_instruction_1(Opcode op, FILE *fp) {
    int operands[3];
    int operand_cnt = 0;

    std::string operand = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        else if (c < ' ' || c == '#') {
            // line ends;
            DEBUG_PRINTF("%s;\n", operand.c_str());
            operands[operand_cnt] = stoi(operand.substr(0));
            getline(fp);
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

    return Instruction(op, operands[0], operands[1], -1, -1, operands[2]);
}

// opcode r, imm(r)
inline Instruction Program::read_instruction_2(Opcode op, FILE *fp) {
    int operands[3];
    int operand_cnt = 0;

    std::string operand = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        else if (c == ')') {
            // line ends;
            DEBUG_PRINTF("%s;\n", operand.c_str());
            operands[operand_cnt] = stoi(operand.substr(1));
            Program::getline(fp);
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

    return Instruction(op, operands[0], operands[2], -1, -1, operands[1]);
}

// opcode r, r, label
inline Instruction Program::read_instruction_3(Opcode op, FILE *fp) {
    int operands[3];
    int operand_cnt = 0;

    std::string operand = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        else if (c < ' ' || c == '#') {
            // line ends;
            DEBUG_PRINTF("%s;\n", operand.c_str());
            if (labels.count(operand) == 0) {
                operands[operand_cnt] = label_cnt;
                labels[operand] = label_cnt;
                labels_address.push_back(-1);
                label_cnt++;
            } 
            else {
                operands[operand_cnt] = labels[operand];
            }
            Program::getline(fp);
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

    return Instruction(op, operands[0], operands[1], -1, operands[2], -1);
}

// opcode r, label
inline Instruction Program::read_instruction_4(Opcode op, FILE *fp) {
    int operands[2];
    int operand_cnt = 0;

    std::string operand = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        else if (c < ' ' || c == '#') {
            // line ends;
            DEBUG_PRINTF("%s;\n", operand.c_str());
            if (labels.count(operand) == 0) {
                operands[operand_cnt] = label_cnt;
                labels[operand] = label_cnt;
                labels_address.push_back(-1);
                label_cnt++;
            } 
            else {
                operands[operand_cnt] = labels[operand];
            }
            Program::getline(fp);
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
    return Instruction(op, operands[0], -1, -1, operands[1], -1);
}

inline Instruction Program::read_instruction_5(Opcode op, FILE *fp) {
    int operands[2];
    int operand_cnt = 0;

    std::string operand = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        else if (c < ' ' || c == '#') {
            // line ends;
            DEBUG_PRINTF("%s;\n", operand.c_str());
            operands[operand_cnt] = stoi(operand.substr(1));
            getline(fp);
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
    return Instruction(op, operands[0], -1, -1, operands[1], -1);
}

inline Instruction Program::read_instruction(FILE *fp) {
    for (int i = 0; i < 3; i++) int c = fgetc(fp);
    std::string opcode = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        if (c == ' ') break;
        opcode += c;
    }

    Instruction inst;

    DEBUG_PRINTF("%s, ", opcode.c_str());

    if (string_to_opcode.count(opcode) == 0) {
        std::cerr << "error: invalid opcode." << std::endl;
        exit(1);
    }

    Opcode op = string_to_opcode[opcode];

    if (op < 100) inst = read_instruction_0(op, fp);
    else if (op < 200) inst = read_instruction_1(op, fp);
    else if (op < 300) inst = read_instruction_2(op, fp);
    else if (op < 400) inst = read_instruction_3(op, fp);
    else if (op < 500) inst = read_instruction_4(op, fp);
    else inst = read_instruction_5(op, fp);

    pc++;

    return inst;
}


inline void Program::read_label(char c, FILE *fp) {
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

    if (labels.count(label) == 0) {
        labels[label] = label_cnt;
        labels_address.push_back(pc);
        label_cnt++;
    } else {
        labels_address[labels[label]] = pc;
    }

    DEBUG_PRINTF("%s,\n", label.c_str());
}

inline void Program::getline(FILE *fp) {
    while(feof(fp) == 0) {
        int c = fgetc(fp);
        if (c == -1) continue;
        if (c == '\n') break;
    }
}

inline void Program::read_program(FILE *fp) {
    while(feof(fp) == 0) {
        int c = fgetc(fp);
        if (c == -1) {
            continue;
        }
        else if ((char)c == ' ') {
            instructions.push_back(read_instruction(fp));
        }   
        else {
            read_label(c, fp);
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

    for(int i = 0; i < labels_address.size(); i++) {
        std::cout << labels_address[i] << std::endl;
    }

    std::cout << instructions.size() << std::endl;
}

inline void Program::exec() {
    pc = 0;
    while(pc != instructions.size()) {
        // std::cout << pc << std::endl;
        pc = instructions[pc].exec(pc, labels_address);
        // for(int i = 0; i < 10; i++) {
        //     std::cout << regis[i] << " ";
        // }
        // std::cout << std::endl;
    }
    std::cout << std::endl << "fib_ans: " << memory[100] << std::endl; 
}