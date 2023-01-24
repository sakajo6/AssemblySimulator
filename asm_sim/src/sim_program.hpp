#pragma once

#include <vector>
#include <string>
#include <map>
#include <algorithm>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <tuple>

#include "sim_instruction.hpp"
#include "sim_opecode.hpp"
#include "sim_global.hpp"
#include "sim_reader.hpp"
#include "sim_assembler.hpp"

#ifdef HARD
#include "sim_cache.hpp"
#include "sim_branch_prediction.hpp"
#endif

class Program {
    private:
        int pc;
        Instruction curinst;

        long long int counter;
        int std_cnt;
        int end_point;

        std::vector<Instruction> instructions;
        std::vector<std::string> input_files;
        std::map<std::string, int> labels;

        #ifdef STATS
        std::vector<long long int> stats; 
        std::vector<long long int> jump_counter;
        std::vector<long long int> luiori_counter;
        #endif

        #ifdef HARD
        Cache instCache;
        Cache dataCache;
        BranchPrediction bp;
        #endif

        std::string print_int_with_comma(long long int);

        #if defined STATS || defined HARD
        void print_stats();
        #endif
        
        #ifdef DEBUG
        void check_load(int, int);
        void check_store(int, int);    
        #endif
         
        void init_source();

    public:
        Program() {
            pc = 0;
            counter = 0;
            instructions = {};
            input_files = {};

            #ifdef HARD
            instCache = Cache(20, 7, 5, 2);
            dataCache = Cache(20, 7, 5, 2);
            bp = BranchPrediction(10);
            #endif

            #ifdef STATS
            stats.assign(100, (long long int)0);
            jump_counter = {};
            luiori_counter = {};
            #endif
        }
        void callReader(int, char const *[]);
        void callAssembler();
        void exec();
};

inline void Program::init_source() {
    for(int i = 0; i < 32; i++) {
        xregs[i] = 0;
        fregs[i] = 0.;
    }

    // stack pointer
    xregs[2] = memory_size;
    
    // heap pointer
    xregs[3] = instructions.size()*4;

    text_data_section = instructions.size()*4;
    pc = 0;
    std_cnt = 0;
}

inline void Program::callReader(int argc, char const *argv[]) {
    Reader reader(&instructions, &input_files, &labels);
    end_point = reader.read_inputs(argc, argv);
}

inline void Program::callAssembler() {
    std::cout << "<<< assembler started..." << std::endl;

    FILE *fp = fopen("./output/bin.txt", "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening ./output/bin.txt.\n" << std::endl;
        exit(1);
    }

    FILE *fpdebug = fopen("./output/bin_debug.txt", "w");
    if (fpdebug == NULL) {
        std::cerr << "error: an error occurred opening ./output/bin_debug.txt.\n" << std::endl;
        exit(1);
    }

    int n = instructions.size();
    for (int i = 0; i < n; i++) {
        Instruction curinst = instructions[i];
        Assembler tempAsm(curinst, fp, fpdebug);
        OpeAssert asmRet = tempAsm.assemble(i*4, veriflag);
        if (asmRet != OK) {
            std::cout << "\t\033[33m[warning]\033[m ";
            if (curinst.filenameIdx == -1) std::cout << "entrypoint, line " << curinst.line << "\t";
            else std::cout << input_files[curinst.filenameIdx] << ", line " << curinst.line << "\t";
            globalfun::print_inst(stdout, curinst);
            std::cout << "\t";
            if (asmRet == Reg0Err) std::cout << "Reg0 is not between 0 - 31" << std::endl;
            else if (asmRet == Reg1Err) std::cout << "Reg1 is not between 0 - 31" << std::endl;
            else if (asmRet == Reg2Err) std::cout << "Reg2 is not between 0 - 31" << std::endl;
            else if (asmRet == ImmErr) std::cout << "Immediate value is out of range" << std::endl;
            else if (asmRet == MemoryOutOfRange) std::cout << "PC is out of memory" << std::endl;
        }
    }

    fclose(fp);
    fclose(fpdebug);
    std::cout << "<<< assembler finished\n" << std::endl;
}

inline std::string Program::print_int_with_comma(long long int n) {
	std::string result=std::to_string(n);
		for(int i=result.size()-3; i>0;i-=3)
			result.insert(i,",");
		return result;		
}

#if defined STATS || defined HARD
inline void Program::print_stats() {
    std::cout << "<<< stats printing started..." << std::endl;

    FILE *fp = fopen("./output/stats.txt", "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening ./output/stats.txt.\n" << std::endl;
        exit(1);
    }    

    #ifdef STATS
    // instruction stats
    std::vector<std::pair<long long int, Opcode>> instr_counter;
    for(int i = 0; i < 100; i++) {
        if (opcode_to_string.count((Opcode)i)) {
            instr_counter.push_back({stats[i], (Opcode)i});
        }
    }
    std::sort(instr_counter.begin(), instr_counter.end(), std::greater<>());
    fprintf(fp, "<<< instruction stats\n");
    fprintf(fp, "\ttotal: \t%s\n", Program::print_int_with_comma(counter).c_str());
    for(auto i: instr_counter) {
        fprintf(fp, "\t%s: \t%s\n", opcode_to_string[i.second].c_str(), Program::print_int_with_comma(i.first).c_str());
    }

    // labels
    std::vector<std::string> labelvector;
    for(auto i: labels) {
        labelvector.emplace_back(i.first);
    }
    // jump stats
    std::vector<std::pair<long long int, int>> jump_counter_sorted;
    for(int i = 0; i < labelvector.size(); i++) {
        jump_counter_sorted.push_back({jump_counter[labels[labelvector[i]]], i});
    }
    std::sort(jump_counter_sorted.begin(), jump_counter_sorted.end(), 
    [](std::pair<long long int, int> a, std::pair<long long int, int> b) {
        if (a.first > b.first) return true;
        else if (a.first == b.first) {
            return a.first < b.first;
        }
        return false;
    });
    fprintf(fp, "\n<<< jump stats\n");
    for(auto i: jump_counter_sorted) {
        fprintf(fp, "\t%s: \t%s\n", labelvector[i.second].c_str(), Program::print_int_with_comma(i.first).c_str());
    }

    // lui/ori stats
    std::vector<std::pair<long long int, int>> luiori_counter_sorted;
    for(int i = 0; i < labelvector.size(); i++) {
        luiori_counter_sorted.push_back({luiori_counter[labels[labelvector[i]]], i});
    }
    std::sort(luiori_counter_sorted.begin(), luiori_counter_sorted.end(), 
    [](std::pair<long long int, int> a, std::pair<long long int, int> b) {
        if (a.first > b.first) return true;
        else if (a.first == b.first) {
            return a.first < b.first;
        }
        return false;
    });
    fprintf(fp, "\n<<< lui/ori stats\n");
    for(auto i: luiori_counter_sorted) {
        fprintf(fp, "\t%s: \t%s\n", labelvector[i.second].c_str(), Program::print_int_with_comma(i.first).c_str());
    }
    #endif 

    #ifdef HARD
    // cache
    fprintf(fp, "\n<<< cache stats\n");
    // inst-cache
    fprintf(fp, "\tinst-cache:\n");
    instCache.printStats(fp);
    // data-cache
    fprintf(fp, "\tdata-cache:\n");
    dataCache.printStats(fp);

    // branch prediction
    fprintf(fp, "\n<<< branch prediction stats\n");
    bp.printStats(fp);
    #endif

    fclose(fp);
    std::cout << "<<< stats printing finished\n" << std::endl;
}
#endif

#ifdef DEBUG
inline void Program::check_load(int addr, int pc) {
    if (addr <= 0 || addr >= memory_size) {
        if (curinst.filenameIdx == -1) std::cout << "\t" << "entrypoint, line " << curinst.line << std::endl;
        else std::cout << "\t" << input_files[curinst.filenameIdx] << ", line " << curinst.line << std::endl;
        std::cout << "\t";
        globalfun::print_inst(stdout, curinst);
        std::cout << "\n\n";
        globalfun::print_regs(binflag);
        if (addr == 0) std::cerr << "error: this is entry-point. pc = " << pc << std::endl;
        else std::cerr <<  "error: memory outof range or accessing text/data section. pc = " << pc << std::endl;
        exit(1);
    }
}

inline void Program::check_store(int addr, int pc) {
    if (addr < text_data_section || addr >= memory_size) {
        if (curinst.filenameIdx == -1) std::cout << "\t" << "entrypoint, line " << curinst.line << std::endl;
        else std::cout << "\t" << input_files[curinst.filenameIdx] << ", line " << curinst.line << std::endl;
        std::cout << "\t";
        globalfun::print_inst(stdout, curinst);
        std::cout << "\n\n";
        globalfun::print_regs(binflag);
        std::cerr << "error: memory outof range or accessing text/data section. pc = " << pc << std::endl;
        exit(1);
    }    
}
#endif
inline void Program::exec() {
    std::cout << "<<< program execution started..." << std::endl; 


    #ifdef STATS
    long long int counter_size = instructions.size()*4;
    jump_counter.assign(counter_size, (long long int)0);
    luiori_counter.assign(counter_size, (long long int)0);
    #endif

    FILE *fp = fopen("./output/output.ppm", "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening ./output/output.ppm.\n" << std::endl;
        exit(1);
    }

    struct timespec start, end;

    // initialization
    Program::init_source();

    clock_gettime(CLOCK_REALTIME, &start);

    // exec
    while(pc != end_point) {
        curinst = instructions[pc/4];

        #ifdef HARD
        // inst-cache
        instCache.cacheAccess(pc, true);
        // data-cache
        Opcode curop = curinst.opcode;
        if (curop == Lw || curop == Flw) {
            unsigned int addr = xregs[curinst.reg1] + curinst.imm;
            dataCache.cacheAccess(addr, true);
        }
        else if (curop == Sw || curop == Fsw) {
            unsigned int addr = xregs[curinst.reg1] + curinst.imm;
            dataCache.cacheAccess(addr, false);
        }

        // branch prediction
        int pc_prev = pc;
        #endif

        Opcode opcode = curinst.opcode;
        // 0 - 15
        if (opcode < 16) {
            // 0 - 7
            if (opcode < 8) {
                // 0 - 3
                if (opcode < 4) {
                    // 0 - 1
                    if (opcode < 2) {
                        switch(opcode) {
                            case Lw: 
                                { 
                                    int addr = xregs[curinst.reg1] + curinst.imm;
                                    if (addr == -1) {
                                        xregs[curinst.reg0] = std_input.at(std_cnt).i;
                                        std_cnt++;
                                    }
                                    else {
                                        #ifdef DEBUG
                                        Program::check_load(addr, pc);
                                        #endif
                                        xregs[curinst.reg0] = memory.at(addr).i;
                                    }
                                    pc += 4;
                                } break;
                            case Addi: xregs[curinst.reg0] = xregs[curinst.reg1] + curinst.imm; pc+=4; break;
                        }
                    }
                    // 2 - 3
                    else {
                        switch(opcode) {
                            case Lui: 
                                #ifdef STATS
                                if (curinst.luioriFlag && 0LL <= curinst.imm && curinst.imm < counter_size) luiori_counter[curinst.imm]++;
                                #endif
                                xregs[curinst.reg0] = (curinst.imm >> 12) << 12; pc+=4; break;
                            case Ori: 
                                #ifdef STATS
                                if (curinst.luioriFlag && 0LL <= curinst.imm && curinst.imm < counter_size) luiori_counter[curinst.imm]++;
                                #endif
                                xregs[curinst.reg0] = xregs[curinst.reg1] | curinst.imm; pc+=4; break;
                        }
                    }
                }
                // 4 - 7
                else {
                    // 4 - 5
                    if (opcode < 6) {
                        switch(opcode) {
                            case Sw: 
                                {
                                    int addr = xregs[curinst.reg1] + curinst.imm;
                                    if (addr == -1) fprintf(fp, "%d", xregs[curinst.reg0]);
                                    else if (addr == -2) fprintf(fp, "%c", (char)xregs[curinst.reg0]);
                                    else {
                                        #ifdef DEBUG
                                        Program::check_store(addr, pc);
                                        #endif
                                        memory.at(addr).i = xregs[curinst.reg0];
                                    }
                                    pc+=4;
                                } break;
                            case Flw: 
                                {   
                                    int addr = xregs[curinst.reg1] + curinst.imm;
                                    if (addr == -1) {
                                        fregs[curinst.reg0] = std_input.at(std_cnt).f;
                                        std_cnt++;
                                    }
                                    else {
                                        #ifdef DEBUG
                                        Program::check_load(addr, pc);
                                        #endif
                                        fregs[curinst.reg0] = memory.at(addr).f; 
                                    }
                                    pc+=4;
                                } break;
                        }
                    }
                    // 6 - 7
                    else {
                        switch(opcode) {
                            case Jalr: xregs[curinst.reg0] = pc+4; pc = xregs[curinst.reg1] + curinst.imm; break;
                            case Add: xregs[curinst.reg0] = xregs[curinst.reg1] + xregs[curinst.reg2]; pc+=4; break;
                        }
                    }
                }
            }
            // 8 - 15
            else {
                // 8 - 11
                if (opcode < 12) {
                    // 8 - 9
                    if (opcode < 10) {
                        switch(opcode){
                            case Mul: xregs[curinst.reg0] = xregs[curinst.reg1] * xregs[curinst.reg2]; pc+=4; break;
                            case Jal: xregs[curinst.reg0] = pc + 4; pc += curinst.imm; break;
                        }
                    }
                    // 10 - 11
                    else {
                        switch(opcode) {
                            case Beq: if (xregs[curinst.reg0] == xregs[curinst.reg1]) {pc += curinst.imm;} else {pc+=4;} break;
                            case Fsub: fregs[curinst.reg0] = fregs[curinst.reg1] - fregs[curinst.reg2]; pc+=4; break;
                        }
                    }
                }
                // 12 - 16
                else {
                    // 12 - 13
                    if (opcode < 14) {                  
                        switch(opcode) { 
                            case Fadd: fregs[curinst.reg0] = fregs[curinst.reg1] + fregs[curinst.reg2]; pc+=4; break;
                            case Fsw: 
                                {   
                                    int addr = xregs[curinst.reg1] + curinst.imm;
                                    #ifdef DEBUG
                                    Program::check_store(addr, pc);
                                    #endif
                                    memory.at(addr).f = fregs[curinst.reg0];
                                    pc+=4;
                                } break;
                        }
                    }
                    // 14 - 15
                    else {
                        switch(opcode) {
                            case Fle: if (fregs[curinst.reg1] <= fregs[curinst.reg2]) { xregs[curinst.reg0] = 1;} else {xregs[curinst.reg0] = 0;}; pc+=4; break;
                            case Fmul: fregs[curinst.reg0] = fregs[curinst.reg1] * fregs[curinst.reg2]; pc+=4; break;
                        }
                    }
                }
            }
        }
        else if (opcode < 50) {
            // 16 - 19
            if (opcode < 20) {
                // 16 - 17
                if (opcode < 18) {
                    switch(opcode) {
                        case Ble: if (xregs[curinst.reg0] <= xregs[curinst.reg1]) { pc += curinst.imm; } else {pc+=4;} break;
                        case Sub: xregs[curinst.reg0] = xregs[curinst.reg1] - xregs[curinst.reg2]; pc+=4; break;
                    }
                }
                // 18 - 19
                else {
                    switch(opcode) {
                        case Feq: if (fregs[curinst.reg1] == fregs[curinst.reg2]) {xregs[curinst.reg0] = 1;} else {xregs[curinst.reg0] = 0;}; pc+=4; break;
                        case Fdiv: fregs[curinst.reg0] = fregs[curinst.reg1] / fregs[curinst.reg2]; pc+=4; break;
                    }
                }
            }
            // 20 - 23
            else {
                // 20 - 21
                if (opcode < 22) {
                    switch(opcode) {
                        case Fsqrt: fregs[curinst.reg0] = sqrt(fregs[curinst.reg1]); pc+=4; break;
                        case Div: xregs[curinst.reg0] = xregs[curinst.reg1] / xregs[curinst.reg2]; pc+=4; break;
                    }
                }
                // 22 - 23
                else {
                    switch(opcode) {
                        case Slt: if (xregs[curinst.reg1] < xregs[curinst.reg2]) {xregs[curinst.reg0] = 1;} else {xregs[curinst.reg0] = 0;}; pc+=4; break;
                        case Bge: if (xregs[curinst.reg0] >= xregs[curinst.reg1]) {pc += curinst.imm;} else {pc+=4;} break;
                    }
                }
            } 
        }
        else if (opcode < 60) {
            if (curinst.filenameIdx == -1) std::cout << "\t" << "entrypoint, line " << curinst.line << std::endl;
            else std::cout << "\t" << input_files[curinst.filenameIdx] << ", line " << curinst.line << std::endl;
            std::cout << "\t";
            globalfun::print_inst(stdout, curinst);
            std::cout << "\n\n";
            globalfun::print_regs(binflag);
            std::cout << "\n\tcurrent pc = " << pc << std::endl;
            std::cerr << "error: this is end-point" << std::endl;
            exit(1);
        }
        else {
            if (curinst.filenameIdx == -1) std::cout << "\t" << "entrypoint, line " << curinst.line << std::endl;
            else std::cout << "\t" << input_files[curinst.filenameIdx] << ", line " << curinst.line << std::endl;
            std::cout << "\t";
            globalfun::print_inst(stdout, curinst);
            std::cout << "\n\n";
            globalfun::print_regs(binflag);
            std::cout << "\n\tcurrent pc = " << pc << std::endl;
            std::cerr << "error: this is data section" << std::endl;
            exit(1);
        }

        xregs[0] = 0;

        #ifdef DEBUG
        if ((curinst.breakpoint || brkallflag) && !brknonflag) {
            if (curinst.filenameIdx == -1) std::cout << "\t" << "entrypoint, line " << curinst.line << std::endl;
            else std::cout << "\t" << input_files[curinst.filenameIdx] << ", line " << curinst.line << std::endl;
            std::cout << "\t";
            globalfun::print_inst(stdout, curinst);
            std::cout << "\n\n";
            globalfun::print_regs(binflag);
            std::cout << "\n\tcurrent pc = " << pc << std::endl;
            std::cout << "\n<<< PRESS ENTER" << std::endl;

            getchar();
        }
        // check next pc
        check_load(pc, pc);
        #endif

        #ifdef STATS
        stats[curinst.opcode]++;
        jump_counter[pc]++;
        #endif 

        #ifdef HARD
        bp.branchUpdate(pc_prev, pc);
        #endif

        counter++;

        if (counter%(long long int)100000000 == 0) {
            std::cout << "<<< executed " << print_int_with_comma(counter) << " instructions" << std::endl;
        }
    }
    
    clock_gettime(CLOCK_REALTIME, &end);


    globalfun::print_regs(binflag);
    
    std::cout << "\telapsed time: ";
    std::cout << (end.tv_sec + end.tv_nsec*1.0e-9) - (start.tv_sec + start.tv_nsec*1.0e-9) << std::endl;
    std::cout << "\tcounter: " << Program::print_int_with_comma(counter) << '\n' << std::endl;

    std::cout << "<<< program finished\n" << std::endl;

    #if defined STATS || defined HARD
    Program::print_stats();
    #endif
}