#pragma once

#include <vector>
#include <string>
#include <map>
#include <algorithm>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <thread>
#include <mutex>
#include <experimental/filesystem>

#include "sim_instruction.hpp"
#include "sim_opecode.hpp"
#include "sim_global.hpp"


class Program {
    private:
        bool minrtflag;

        int line;
        int pc;

        std::vector<Instruction> instructions;
        std::map<std::string, int> labels;
        std::vector<int> stats; 

        std::vector<std::string> input_files;
        std::string current_file;

        int sld_datacnt;
        std::vector<bool> sld_intfloat;

        int endpoint;

        void read_line(FILE *);
        void read_operand(std::string, int &, Instruction &);
        Instruction read_instruction(FILE *, bool);
        void read_label();
        void read_program();
        void print_segfault(int);
        void read_sld_int(std::string &, int &);
        void read_sld_float(std::string &, int &);
        void read_sld();
        void read_inputfiles(int, char const *[]);
        
        void init_source();
        
        std::string print_int_with_comma(long long int);
        void print_debug();
        void assembler();
        void print_stats();

    public:
        Program() {
            minrtflag = false;

            line = 0;
            pc = 0;
            instructions = {};
            input_files = {};

            endpoint = 0;
            sld_datacnt = 0;

            labels.clear();
            stats.assign(100, 0);

            sld_intfloat = {};
        }
        void read_inputs(int, char const *argv[]);
        void exec();
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
            if (labels.count(operand) == 0) {
                std::cerr << "error: undefined label. `" << operand << "`" << std::endl;
                exit(1);
            } 
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
        if (labels.count(operand) == 0) {
            std::cerr << "error: undefined label `" << operand << "`" << std::endl;
            exit(1);
        }
        else inst.imm = labels[operand] - pc;
    }
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
        std::cerr << "error: invalid opcode: `" << opcode << "`" << std::endl;
        exit(1);
    }

    Opcode op = string_to_opcode[opcode];
    Instruction inst(line, op, brkp, current_file);
    
    if (op == Exit) {
        endpoint = pc;
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
                        if (c == '\t') Program::read_line(fp);
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
                Program::read_line(fp);
            }
            else if (c == '\t' || c == '*') {
                line++;
                pc += 4;
                Program::read_line(fp);
            }   
            else {
                line++;
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

    labels["data"] = pc;

    std::cout << "<<< label reading finished\n" << std::endl;
}

inline void Program::read_program() {
    std::cout << "<<< program reading started..." << std::endl;

    Instruction entrypoint(0, Jal, false, "entrypoint");
    entrypoint.reg0 = 0;
    entrypoint.imm = labels["min_caml_start"];
    instructions.push_back(entrypoint);

    FILE *fpout = fopen("./output/pcToFilepos.txt", "w");
    if (fpout == NULL) {
        std::cerr << "error: an error occurred opening ./output/pcAndInst.txt.\n" << std::endl;
        exit(1);   
    }
    pc = 4;
    for(auto fn: input_files) {
        if (fn.substr(fn.size() - 2) != ".s") continue;

        FILE *fp = fopen(fn.c_str(), "r");
        if (fp == NULL) {
            std::cerr << "error: an error occurred opening " << fn << ".\n" << std::endl;
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
                Instruction tempinst = read_instruction(fp, false);

                fprintf(fpout, "\t%d:  \t", pc - 4);
                tempinst.print_debug(fpout);
                fprintf(fpout, "\t\t%s:%d\n", fn.c_str(), line);

                instructions.push_back(tempinst);
            }   
            else if (c == '*') {
                line++;
                fgetc(fp);
                Instruction tempinst = read_instruction(fp, true);

                fprintf(fpout, "\t%d:  \t", pc - 4);
                tempinst.print_debug(fpout);
                fprintf(fpout, "\t\t%s:%d\n", fn.c_str(), line);

                instructions.push_back(tempinst);
            }
            else {
                line++;
                Program::read_line(fp);
            }
        }   
        fclose(fp);
    }

    fclose(fpout);
    
    std::cout << "<<< program reading finished\n" << std::endl;
}

inline void Program::print_segfault(int addr) {
    if (addr < 0 || addr > memory_size) {
        std::cerr << "error: memory outof range. tried to access memory[" << addr << "]" << std::endl;
        exit(1);
    }
}

inline void Program::read_sld_int(std::string &num, int &addr) {
    Program::print_segfault(addr);
    sld_intfloat.push_back(false);
    memory.at(addr*4).i = std::stoi(num);
    addr++;
}

inline void Program::read_sld_float(std::string &num, int &addr) {
    Program::print_segfault(addr);
    sld_intfloat.push_back(true);
    memory.at(addr*4).f = std::stof(num);
    addr++;
}

inline void Program::read_sld() {
    std::cout << "<<< sld reading started" << std::endl;

    for(auto fn: input_files) {
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
        int inst_size = instructions.size();
        int addr = inst_size;

        if (minrtflag) {
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
        else {
            for(int i = 0; i < sld_datacnt; i++) {
                Program::print_segfault(addr*4);

                bool flag = false;
                int len = nums[i].size();
                for(int j = 0; j < len; j++) if (nums[i][j] == '.') flag = true;
                
                sld_intfloat.push_back(flag);
                if (flag) memory.at(addr*4).f = std::stof(nums[i]);
                else memory.at(addr*4).i = std::stoi(nums[i]);

                addr++;
            }
        }
    }
    std::cout << "<<< sld reading finished\n" << std::endl;
}

inline void Program::read_inputfiles(int argc, char const *argv[]) {
    // input files
    std::string path = "./input";
    for(const auto &file: std::experimental::filesystem::directory_iterator(path)) {
        input_files.push_back(file.path());
    }
    std::cout << "<<< input files" << std::endl;
    sort(input_files.begin(), input_files.end());
    for(auto fn: input_files) {
        if (fn == "./input/minrt.s") minrtflag = true;
        std::cout << "\t\033[32m" << fn << "\033[m" << std::endl;
    }
    std::cout << std::endl;

    // options
    char binoption[] = "--bin";
    char brkalloption[] = "--brkall";
    char brknonoption[] = "--brknon";
    char verioption[] = "--veri";
    char debugoption[] = "--debug";

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
}

inline std::string Program::print_int_with_comma(long long int n) {
	std::string result=std::to_string(n);
		for(int i=result.size()-3; i>0;i-=3)
			result.insert(i,",");
		return result;		
}

inline void Program::print_debug() {
    std::cout << "<<< debug started..." << std::endl;

    FILE *fp = fopen("./output/debug.txt", "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening ./output/debug.txt.\n" << std::endl;
        exit(1);
    }    

    int inst_num = (int)instructions.size();
    fprintf(fp, "<<< instruction counter: %d\n", inst_num);
    for(int i = 0; i < inst_num; i++) {
        Instruction tmp_inst = instructions[i];
        fprintf(fp, "\t%d:  \t", i*4);
        tmp_inst.print_debug(fp);
        fprintf(fp, "\n");
    }

    fprintf(fp, "\n<<< labels\n");
    for(auto i: labels) {
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

inline void Program::read_inputs(int argc, char const *argv[]) {
    Program::read_inputfiles(argc, argv);
    Program::read_label();
    Program::read_program();
    Program::read_sld();

    Program::print_debug();
}

inline void Program::print_stats() {
    std::cout << "<<< stats printing started..." << std::endl;

    FILE *fp = fopen("./output/stats.txt", "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening ./output/stats.txt.\n" << std::endl;
        exit(1);
    }    

    std::vector<std::pair<int, Opcode>> instr_counter;
    for(int i = 0; i < 100; i++) {
        if (opcode_to_string.count((Opcode)i)) {
            instr_counter.push_back({stats[i], (Opcode)i});
        }
    }
    std::sort(instr_counter.begin(), instr_counter.end(), std::greater<>());
    for(auto i: instr_counter) {
        fprintf(fp, "%s: \t%s\n", opcode_to_string[i.second].c_str(), Program::print_int_with_comma(i.first).c_str());
    }

    fclose(fp);
    std::cout << "<<< stats printing finished\n" << std::endl;
}

inline void Program::init_source() {
    for(int i = 0; i < 32; i++) {
        xregs[i] = 0;
        fregs[i] = 0.;
    }

    xregs[2] = memory_size;
    xregs[3] = (instructions.size() + sld_datacnt)*4;

    // regs for input
    xregs[29] = 0;
    xregs[30] = 0;

    text_data_section = (instructions.size() + sld_datacnt)*4;
}

void input_thread(int num) {
    for(int i = 0; i < num; i++) {
        std::this_thread::sleep_for(std::chrono::microseconds(30));
        xregs[29] += 4;
    }
}

inline void Program::exec() {
    Program::assembler();

    std::cout << "<<< program execution started..." << std::endl; 

    // initialization
    Program::init_source();

    FILE *fp = fopen("./output/output.ppm", "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening ./output/output.ppm.\n" << std::endl;
        exit(1);
    }

    struct timespec start, end;

    clock_gettime(CLOCK_REALTIME, &start);

    std::thread th(input_thread, sld_datacnt);

    long long int counter = 0;
    pc = 0;
    if (endpoint == 0) {
        std::cerr << "error: please include `EXIT` in .s" << std::endl;
    }
    while(pc != endpoint) {
        Instruction curinst = instructions[pc/4];
        pc = curinst.exec(fp, pc);

        if (pc == 0) {
            globalfun::print_regs(binflag);
        }
        assert(pc != 0);

        stats[curinst.opcode]++;
        counter++;

        if (counter%(long long int)100000000 == 0) {
            std::cout << "<<< executed " << print_int_with_comma(counter) << " instructions" << std::endl;
        }
    }


    std::cout << "\n<<< thread joining..." << std::endl;
    th.join();

    clock_gettime(CLOCK_REALTIME, &end);


    globalfun::print_regs(binflag);
    
    std::cout << "\telapsed time: ";
    std::cout << (end.tv_sec + end.tv_nsec*1.0e-9) - (start.tv_sec + start.tv_nsec*1.0e-9) << std::endl;
    std::cout << "\tcounter: " << Program::print_int_with_comma(counter) << '\n' << std::endl;

    std::cout << "<<< program finished\n" << std::endl;


    Program::print_stats();
}

inline void Program::assembler() {
    std::cout << "<<< assembler started..." << std::endl;

    FILE *fp = fopen("./output/bin.txt", "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening ./output/bin.txt.\n" << std::endl;
        exit(1);
    }

    int n = instructions.size();
    for (int i = 0; i < n; i++) {
        instructions[i].assemble(fp, i, veriflag);
    }

    fclose(fp);
    std::cout << "<<< assembler finished\n" << std::endl;
}
