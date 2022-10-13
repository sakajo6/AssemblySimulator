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

class Program {
    private:
        int pc;
        std::vector<Instruction> instructions;

        int label_cnt;
        std::map<std::string, int> labels;
        std::vector<int> labels_address;

        int memory[1024];
        int regis[32];

        Instruction read_instruction_0(Opcode op, FILE *fp);
        Instruction read_instruction_1(Opcode op, FILE *fp);
        Instruction read_instruction_2(Opcode op, FILE *fp);
        Instruction read_instruction_3(Opcode op, FILE *fp);
        Instruction read_instruction_4(Opcode op, FILE *fp);

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

            for(int i = 0; i < 1024; i++) {
                memory[i] = 0;
            }
            for(int i = 0; i < 32; i++) {
                regis[i] = 0;
            }
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

inline Instruction Program::read_instruction(FILE *fp) {
    for (int i = 0; i < 3; i++) int c = fgetc(fp);
    std::string opcode = "";
    while(feof(fp) == 0) {
        char c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        if (c == ' ') break;
        opcode += c;
    }

    Instruction inst(Add, -1, -1, -1, -1, -1);

    DEBUG_PRINTF("%s, ", opcode.c_str());

    // pattern 0
    if (opcode == "add") inst = read_instruction_0(Add, fp);
    else if (opcode == "sub") inst = read_instruction_0(Sub, fp);
    else if (opcode == "slt") inst = read_instruction_0(Slt, fp);

    // pattern 1
    else if (opcode == "addi") inst = read_instruction_1(Addi, fp);

    // pattern 2
    else if (opcode == "lw") inst = read_instruction_2(Lw, fp);
    else if (opcode == "sw") inst = read_instruction_2(Sw, fp);
    else if (opcode == "jalr") inst = read_instruction_2(Jalr, fp);

    // pattern 3
    else if (opcode == "beq") inst = read_instruction_3(Beq, fp);
    else if (opcode == "blt") inst = read_instruction_3(Blt, fp);
    else if (opcode == "bge") inst = read_instruction_3(Bge, fp);

    // pattern 4
    else if (opcode == "jal") inst = read_instruction_4(Jal, fp);

    // others
    else {
        std::cerr << "error: opcode parse error; " << opcode << std::endl;
        exit(1);
    }

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
        pc = instructions[pc].exec(pc, labels_address, memory, regis);
        // for(int i = 0; i < 10; i++) {
        //     std::cout << regis[i] << " ";
        // }
        // std::cout << std::endl;
    }
    std::cout << std::endl << "fib_ans: " << memory[100] << std::endl; 
}