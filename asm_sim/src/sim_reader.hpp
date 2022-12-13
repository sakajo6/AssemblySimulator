#pragma once

#include <vector>
#include <string>
#include <map>
#include <experimental/filesystem>


#include "sim_instruction.hpp"


class Reader {
    private:
        int line;
        int pc;

        std::vector<Instruction> *instructions;
        int sld_datacnt;
        int end_point;

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
            sld_datacnt = 0;
            end_point = 0;

            labels = labels_addr;
            input_files = inputs;

            sld_intfloat = {};
        };
        std::tuple<int, int> read_inputs(int, char const *[]);
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
                    else if (c == '\n' || c == '\t') {
                        if (c == '\t') Reader::read_line(fp);
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
                        else if (c == '\n' || c == '\t' || c == ')') {
                            if (c == '\t' || c == ')') Reader::read_line(fp);
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

    (*labels)["data"] = pc;

    std::cout << "<<< label reading finished\n" << std::endl;
}

inline void Reader::read_program() {
    std::cout << "<<< program reading started..." << std::endl;

    Instruction entrypoint(0, Jal, false, -1);
    entrypoint.reg0 = 0;
    entrypoint.imm = (*labels)["min_caml_start"];
    (*instructions).push_back(entrypoint);

    FILE *fpout = fopen("./output/pcToFilepos.txt", "w");
    if (fpout == NULL) {
        std::cerr << "error: an error occurred opening ./output/pcAndInst.txt.\n" << std::endl;
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
    Reader::print_segfault(addr);
    sld_intfloat.push_back(false);
    memory.at(addr*4).i = std::stoi(num);
    addr++;
}

inline void Reader::read_sld_float(std::string &num, int &addr) {
    Reader::print_segfault(addr);
    sld_intfloat.push_back(true);
    memory.at(addr*4).f = std::stof(num);
    addr++;
}

inline void Reader::read_sld() {
    std::cout << "<<< sld reading started" << std::endl;

    for(auto fn: *input_files) {
        if (fn.substr(fn.size() - 2) == ".s") continue;

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


        sld_datacnt = (int)nums.size();
        int inst_size = (*instructions).size();
        int addr = inst_size;

        // line 1
        for(int i = 0; i < 5; i++) read_sld_float(nums[addr - inst_size], addr);

        // line 2, 3
        read_sld_int(nums[addr - inst_size], addr);
        for(int i = 0; i < 3; i++) read_sld_float(nums[addr - inst_size], addr);

        // line 4 ...
        while(true) {
            if (nums[addr - inst_size] == "-1") break;
            for(int i = 0; i < 4; i++) read_sld_int(nums[addr - inst_size], addr);
            for(int i = 0; i < 12; i++) read_sld_float(nums[addr - inst_size], addr);
        }

        // til EOF
        int tilEOF = sld_datacnt - (addr - inst_size);
        for(int i = 0; i < tilEOF; i++) read_sld_int(nums[addr - inst_size], addr);
    }
    std::cout << "<<< sld reading finished\n" << std::endl;
}

inline void Reader::read_inputfiles(int argc, char const *argv[]) {
    // options
    char binoption[] = "--bin";
    char brkalloption[] = "--brkall";
    char brknonoption[] = "--brknon";
    char verioption[] = "--veri";

    std::cout << "<<< runtime arguments:" << std::endl;
    std::cout << "\t\033[31m--bin:  \toutput register values in binary\033[m" << std::endl;
    std::cout << "\t\033[31m--brkall:\tassign break-pointer to all instructions\033[m" << std::endl;
    std::cout << "\t\033[31m--brknon:\tignore all break-pointer\033[m" << std::endl;
    std::cout << "\t\033[31m--veri: \toutput binary in verilog style\033[m\n" << std::endl;

    std::cout << "<<< These are runtime arguments.\n" << std::endl;

    binflag = false;
    brkallflag = false;
    brknonflag = false;
    veriflag = false;

    for(int i = 1; i < argc; i++) {
        if (strcmp(argv[i], binoption) == 0) binflag = true;
        else if (strcmp(argv[i], brkalloption) == 0) brkallflag = true;
        else if (strcmp(argv[i], brknonoption) == 0) brknonflag = true;
        else if (strcmp(argv[i], verioption) == 0) veriflag = true;
        else {
            std::cerr << "<<< runtime parameters are invalid" << std::endl;
            exit(1);
        }
    }

    // input files
    std::string path = "./input";
    for(const auto &file: std::experimental::filesystem::directory_iterator(path)) {
        (*input_files).push_back(file.path());
    }
    std::cout << "<<< input files" << std::endl;
    sort((*input_files).begin(), (*input_files).end());

    bool minrtflag = false;
    for(auto fn: *input_files) {
        if (fn == "./input/minrt.s") minrtflag = true;
        std::cout << "\t\033[32m" << fn << "\033[m" << std::endl;
    }
    std::cout << std::endl;

    if (!minrtflag) {
        std::cerr << "please include 'minrt.s' in input files." << std::endl;
        exit(1);
    }

}

inline void Reader::print_debug() {
    std::cout << "<<< debug started..." << std::endl;

    FILE *fp = fopen("./output/debug.txt", "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening ./output/debug.txt.\n" << std::endl;
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

    fprintf(fp, "\n<<< sld input: %d\n", sld_datacnt);
    for(int i = inst_num; i < inst_num + sld_datacnt; i++) {
        if (i < 0 || i >= memory_size) {
            std::cerr << "error: memory outof range. sld input data = " << i << std::endl;
            exit(1);
        }
        if (sld_intfloat[i - inst_num]) fprintf(fp, "\t%f\n", memory.at(i*4).f);
        else fprintf(fp, "\t%d\n", memory.at(i*4).i);
    }

    fclose(fp);
    std::cout << "<<< debug finished\n" << std::endl;
}


inline std::tuple<int, int> Reader::read_inputs(int argc, char const *argv[]) {
    Reader::read_inputfiles(argc, argv);
    Reader::read_label();
    Reader::read_program();
    Reader::read_sld();

    Reader::print_debug();

    return std::forward_as_tuple(sld_datacnt, end_point);
}