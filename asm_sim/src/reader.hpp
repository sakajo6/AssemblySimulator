#pragma once

#include <vector>
#include <string>
#include <map>
#include <experimental/filesystem>

#include "global.hpp"
#include "instruction.hpp"


class Reader {
    private:
        int line;
        int pc;

        int std_cnt;
        int end_point;
        std::vector<Instruction> *instructions;

        std::map<std::string, int> *labels;
        std::vector<std::string> *input_files;
    
        std::vector<bool> sld_intfloat;

        void read_line(FILE *);
        void read_operand(std::string, int &, Instruction &);
        Instruction read_instruction(FILE *, bool, int);
        void read_label();
        void read_program();
        void print_segfault(int);
        void read_sld_int(std::string &, int &);
        void read_sld_float(std::string &, int &);
        void read_sld();
        void read_inputfiles(int, char const *[]);

        void print_debug();

    public:
        Reader(std::vector<Instruction> *insts, std::vector<std::string> *inputs, std::map<std::string, int> *labels_addr) {
            line = 0;
            pc = 0;

            instructions = insts;
            end_point = 0;

            labels = labels_addr;
            input_files = inputs;

            sld_intfloat = {};
            std_input = {};
        };
        int read_inputs(int, char const *[]);
};


inline void Reader::read_line(FILE *fp) {
    while(feof(fp) == 0) {
        int c = fgetc(fp);
        if (c == -1) continue;
        if (c == '\n') break;
    }
}

inline void Reader::read_operand(std::string operand, int &regcnt, Instruction &inst) {
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
            if ((*labels).count(operand) == 0) {
                std::cerr << "error: undefined label. `" << operand << "`" << std::endl;
                exit(1);
            } 
            else inst.imm = (*labels)[operand] - pc;
        }
    }
    // imm: [0-9, -] 始まり
    else if ((operand[0] >= '0' && operand[0] <= '9') || operand[0] == '-') {
        inst.imm = stoi(operand.substr(0));
    }
    // %hi, %lo: % 始まり
    else if (operand[0] == '%') {
        if ((*labels).count(operand.substr(1)) == 0) inst.imm = -4;
        else {
            #ifdef STATS
            inst.luioriFlag = true;
            #endif
            inst.imm = (*labels)[operand.substr(1)];
        }
    }
    // label: その他
    else {
        if ((*labels).count(operand) == 0) {
            std::cerr << "error: undefined label `" << operand << "`" << std::endl;
            exit(1);
        }
        else inst.imm = (*labels)[operand] - pc;
    }
}

inline Instruction Reader::read_instruction(FILE *fp, bool brkp, int i) {
    char c;

    std::string opcode = "";
    while(feof(fp) == 0) {
        c = (char)fgetc(fp);
        if ((int)c == -1) continue;
        if (c == '\t') break;
        opcode += c;
    }

    if (string_to_opcode.count(opcode) == 0) {
        std::cerr << "error: invalid opcode: `" << opcode << "`" << std::endl;
        exit(1);
    }

    Opcode op = string_to_opcode[opcode];
    Instruction inst(line, op, brkp, i);
    
    if (op == Exit) {
        end_point = pc;
    }
    else if (op == Word) {
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
                    else if (c == '\n' || c == '\t' || c == 13) {
                        if (c == '\t' || c == 13) Reader::read_line(fp);
                        inst.fimm = std::stof(operand);
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
                                    Reader::read_line(fp);
                                    flag = true;
                                    read_operand("%" + operand, regcnt, inst);
                                    break;
                                }
                                else operand += c;
                            }
                            break;
                        }
                        else if (c == '\n' || c == '\t' || c == ')' || c == 13) {
                            if (c == '\t' || c == ')' || c == 13) Reader::read_line(fp);
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

inline void Reader::read_label() {
    std::cout << "<<< label reading started..." << std::endl;

    pc = 4;
    for(auto fn: *input_files) {
        if (fn.substr(fn.size() - 2) != ".s") continue;

        FILE *fp = fopen(fn.c_str(), "r");
        if (fp == NULL) {
            std::cerr << "error: an error occurred opening " << fn << ".\n" << std::endl;
            exit(1);
        }
        
        std::string label = "";
        line = 0;
        while(feof(fp) == 0) {
            char c = (char)fgetc(fp);
            if ((int)c == -1) {
                continue;
            }
            else if (c == ' ') {
                line++;
                std::cerr << "error: parse error at " << fn << " line " << line << std::endl;
                exit(1);
            }
            else if (c == '.') {
                line++;
                Reader::read_line(fp);
            }
            else if (c == '\t' || c == '*') {
                line++;
                pc += 4;
                Reader::read_line(fp);
            }   
            else {
                line++;
                label = "";
                label += c;
                while(feof(fp) == 0) {
                    char c = (char)fgetc(fp);
                    if ((int)c == -1) continue;
                    else if (c == ':') {
                        Reader::read_line(fp);
                        break;
                    }
                    label += c;
                }

                (*labels)[label] = pc;
            }
        }
        fclose(fp);
    }

    // (*labels)["data"] = pc;

    std::cout << "<<< label reading finished\n" << std::endl;
}

inline void Reader::read_program() {
    std::cout << "<<< program reading started..." << std::endl;

    Instruction entrypoint(0, Jal, false, -1);
    entrypoint.reg0 = 0;
    entrypoint.imm = (*labels)["min_caml_start"];
    (*instructions).push_back(entrypoint);

    FILE *fpout = fopen((path + "/pcToFilepos.txt").c_str(), "w");
    if (fpout == NULL) {
        std::cerr << "error: an error occurred opening ./files/****/pcAndInst.txt.\n" << std::endl;
        exit(1);   
    }
    pc = 4;
    for(int i = 0; i < (*input_files).size(); i++) {
        std::string fn = (*input_files)[i];
        if (fn.substr(fn.size() - 2) != ".s") continue;

        FILE *fp = fopen(fn.c_str(), "r");
        if (fp == NULL) {
            std::cerr << "error: an error occurred opening " << fn << ".\n" << std::endl;
            exit(1);
        }

        line = 0;
        while(feof(fp) == 0) {
            char c = fgetc(fp);
            if ((int)c == -1) {
                continue;
            }
            else if (c == '.') {
                line++;
                Reader::read_line(fp);
            }
            else if (c == '\t') {
                line++;
                Instruction tempinst = read_instruction(fp, false, i);

                fprintf(fpout, "\t%d:  \t", pc - 4);
                globalfun::print_inst(fpout, tempinst);
                fprintf(fpout, "\t\t%s:%d\n", fn.c_str(), line);

                (*instructions).push_back(tempinst);
            }   
            else if (c == '*') {
                line++;
                fgetc(fp);
                Instruction tempinst = read_instruction(fp, true, i);

                fprintf(fpout, "\t%d:  \t", pc - 4);
                globalfun::print_inst(fpout, tempinst);
                fprintf(fpout, "\t\t%s:%d\n", fn.c_str(), line);

                (*instructions).push_back(tempinst);
            }
            else {
                line++;
                Reader::read_line(fp);
            }
        }   
        fclose(fp);
    }

    fclose(fpout);

    if (end_point == 0) {
        std::cerr << "error: please include 'EXIT' in .s" << std::endl;
        exit(1);
    }
    
    std::cout << "<<< program reading finished\n" << std::endl;
}

inline void Reader::print_segfault(int addr) {
    if (addr < 0 || addr > memory_size) {
        std::cerr << "error: memory outof range. tried to access memory[" << addr << "]" << std::endl;
        exit(1);
    }
}

inline void Reader::read_sld_int(std::string &num, int &addr) {
    sld_intfloat.push_back(false);
    U u;
    u.i = std::stoi(num);
    std_input.push_back(u);
    addr++;
}

inline void Reader::read_sld_float(std::string &num, int &addr) {
    sld_intfloat.push_back(true);
    U u;
    u.f = std::stof(num);
    std_input.push_back(u);
    addr++;
}

inline void Reader::read_sld() {
    std::cout << "<<< sld reading started" << std::endl;

    for(auto fn: *input_files) {
        if (fn.substr(fn.size() - 3) != "sld") continue;

        FILE *fp = fopen(fn.c_str(), "r");
        if (fp == NULL) {
            std::cerr << "error: an error occurred opening " << fn << ".\n" << std::endl;
            exit(1);
        }

        std::vector<std::string> nums = {};
        std::string num = "";
        bool reading = false;
        while(feof(fp) == 0) {
            char c = fgetc(fp);
            if ((int)c == -1) {
                continue;
            }
            else if (c == '\n' || c == ' ') {
                if (reading) {
                    nums.push_back(num);
                    num = "";
                }
                reading = false;
            }
            else {
                reading = true;
                num += c;
            }
        }
        if (num.size() != 0) {
            nums.push_back(num);
        }


        std_cnt = (int)nums.size();
        int addr = 0;

        // line 1
        for(int i = 0; i < 5; i++) read_sld_float(nums[addr], addr);

        // line 2, 3
        read_sld_int(nums[addr], addr);
        for(int i = 0; i < 3; i++) read_sld_float(nums[addr], addr);

        // line 4 ...
        while(true) {
            if (nums[addr] == "-1") break;
            for(int i = 0; i < 4; i++) read_sld_int(nums[addr], addr);
            for(int i = 0; i < 12; i++) read_sld_float(nums[addr], addr);
        }

        // til EOF
        int tilEOF = std_cnt - addr;
        for(int i = 0; i < tilEOF; i++) read_sld_int(nums[addr], addr);
    }
    std::cout << "<<< sld reading finished\n" << std::endl;
}

inline void Reader::read_inputfiles(int argc, char const *argv[]) {
    // options
    char binoption[] = "--bin";
    char brkalloption[] = "--brkall";
    char brknonoption[] = "--brknon";

    std::cout << "<<< runtime arguments:" << std::endl;
    std::cout << "\t\033[31m--bin:  \toutput register values in binary\033[m" << std::endl;
    std::cout << "\t\033[31m--brkall:\tassign break-pointer to all instructions\033[m" << std::endl;
    std::cout << "\t\033[31m--brknon:\tignore all break-pointer\033[m" << std::endl;

    std::cout << "<<< These are runtime arguments.\n" << std::endl;

    binflag = false;
    brkallflag = false;
    brknonflag = false;

    for(int i = 1; i < argc; i++) {
        if (strcmp(argv[i], binoption) == 0) binflag = true;
        else if (strcmp(argv[i], brkalloption) == 0) brkallflag = true;
        else if (strcmp(argv[i], brknonoption) == 0) brknonflag = true;
        else {
            std::cerr << "<<< runtime parameters are invalid" << std::endl;
            exit(1);
        }
    }

    // input files
    std::string input_folder;
    std::cout << "<<< please input folder name" << std::endl;
    std::cout << "./files/";
    std::cin >> input_folder;
    getchar();

    path = "./files/" + input_folder;
    for(const auto &file: std::experimental::filesystem::directory_iterator(path)) {
        (*input_files).push_back(file.path());
    }
    std::cout << "<<< input files" << std::endl;
    sort((*input_files).begin(), (*input_files).end());

    bool minrtflag = false;
    for(auto fn: *input_files) {
        if (fn == path + "/minrt.s") minrtflag = true;
        std::string file_ext = fn.substr(fn.size() - 4, fn.size());
        if (file_ext.substr(0, 4) == ".sld" || file_ext.substr(2, 4) == ".s") {
            std::cout << "\t\033[32m" << fn << "\033[m" << std::endl;
        }
    }
    std::cout << std::endl;

    if (!minrtflag) {
        std::cerr << "please include 'minrt.s' in input files." << std::endl;
        exit(1);
    }

}

inline void Reader::print_debug() {
    std::cout << "<<< debug started..." << std::endl;

    FILE *fp = fopen((path + "/debug.txt").c_str(), "w");
    FILE *fpbase = fopen((path + "/base.txt").c_str(), "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening ./files/****/debug.txt.\n" << std::endl;
        exit(1);
    }    

    int inst_num = (int)(*instructions).size();
    fprintf(fp, "<<< instruction counter: %d\n", inst_num);
    for(int i = 0; i < inst_num; i++) {
        Instruction tmp_inst = (*instructions)[i];

        fprintf(fp, "\t%d:  \t", i*4);
        globalfun::print_inst(fp, tmp_inst);
        fprintf(fp, "\n");
    }

    fprintf(fp, "\n<<< labels\n");
    for(auto i: *labels) {
        fprintf(fp, "\t%s: %d\n", i.first.c_str(), i.second);
    }

    fprintf(fp, "\n<<< sld input: %d\n", std_cnt);

    int cnt = 0;
    for(int i = 0; i < std_cnt; i++) {
        if (sld_intfloat[i]) {
            fprintf(fp, "\t%08x\t%f\n", (unsigned int)std_input.at(i).i, std_input.at(i).f);
            globalfun::print_byte_hex(fpbase, (unsigned int)std_input.at(i).i);
            // fprintf(fpbase, "%08x\n", (unsigned int)std_input.at(i).i);
        }
        else {
            fprintf(fp, "\t%08x\t%d\n", (unsigned int)std_input.at(i).i, std_input.at(i).i);
            globalfun::print_byte_hex(fpbase, (unsigned int)std_input.at(i).i);
            // fprintf(fpbase, "%08x\n", (unsigned int)std_input.at(i).i);
        }

        // unsigned int val = std_input.at(i).i;
        // unsigned int upperval = val / (1 << 16);
        // unsigned int lowerval = val % (1 << 16);

        // fprintf(fp, "%04x ", upperval);
        // fprintf(fp, "%04x ", lowerval);

        // cnt++;
        // if (cnt % 4 == 0) {
        //     fprintf(fp, "\n");
        // }
    }

    fclose(fp);
    fclose(fpbase);
    std::cout << "<<< debug finished\n" << std::endl;
}


inline int Reader::read_inputs(int argc, char const *argv[]) {
    Reader::read_inputfiles(argc, argv);
    Reader::read_label();
    Reader::read_program();
    Reader::read_sld();

    Reader::print_debug();

    return end_point;
}