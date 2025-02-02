#pragma once

#include <vector>
#include <string>
#include <map>
#include <algorithm>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <tuple>

#include "instruction.hpp"
#include "opecode.hpp"
#include "global.hpp"
#include "reader.hpp"
#include "assembler.hpp"

#ifdef PROD
#include "fpu.hpp"
#include "cache.hpp"
#include "branch_prediction.hpp"
#include "time_prediction.hpp"
#endif

class Program {
    private:
        int pc;
        Instruction curinst;

        long long int counter;
        int stdin_cnt;
        int end_point;

        std::vector<Instruction> instructions;
        std::vector<std::string> input_files;
        std::map<std::string, int> labels;

        std::string print_int_with_comma(long long int);
        void check_load(int, int);
        void check_store(int, int); 
        void init_source();

        #ifdef STATS
        std::vector<long long int> stats; 
        #endif

        #ifdef PROD
        FPU fpu;
        Cache instCache;
        Cache dataCache;
        BranchPrediction branchPrediction;
        #endif

        #if defined STATS || defined PROD
        void print_stats();
        #endif
        
    public:
        Program() {
            pc = 0;
            counter = 0;
            instructions = {};
            input_files = {};

            #ifdef PROD
            // tag, index, offset
            instCache = Cache(
                InstCache,
                instCache_tagSiz,
                instCache_indexSiz,
                instCache_offsetSiz,
                instCache_waySiz);
            dataCache = Cache(
                DataCache,
                dataCache_tagSiz,
                dataCache_indexSiz,
                dataCache_offsetSiz,
                dataCache_waySiz);

            // GHR_length, BW
            branchPrediction = BranchPrediction(BW);
            #endif

            #ifdef STATS
            stats.assign(stats_siz, (long long int)0);
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

    text_data_section = instructions.size()*4;
    pc = 0;
    stdin_cnt = 0;
}

inline void Program::callReader(int argc, char const *argv[]) {
    Reader reader(&instructions, &input_files, &labels);
    end_point = reader.read_inputs(argc, argv);
}

inline void Program::callAssembler() {
    std::cout << "<<< assembler started..." << std::endl;

    binary.open(path + "/binary.bin", std::ios::out|std::ios::binary|std::ios::trunc); 
    if (!binary) {
        std::cerr << "error: an error occurred opening ./files/****/binary.bin";
        exit(1);
    }

    FILE *fp = fopen((path + "/binary.txt").c_str(), "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening ./files/****/binary.txt.\n" << std::endl;
        exit(1);
    }

    FILE *fpdebug = fopen((path + "/bin_debug.txt").c_str(), "w");
    if (fpdebug == NULL) {
        std::cerr << "error: an error occurred opening ./files/****/bin_debug.txt.\n" << std::endl;
        exit(1);
    }

    int n = instructions.size();
    for (int i = 0; i < n; i++) {
        Instruction curinst = instructions[i];

        fprintf(fpdebug, "\npc = %d\n", i*4);
        globalfun::print_inst(fpdebug, curinst);
        fprintf(fpdebug, "\n");

        Assembler tempAsm(curinst, fp, fpdebug);
        AssembleResp assembleResp = tempAsm.assemble(i*4);
        
        // store instruction to inst-cache
        U stored_data;
        stored_data.i = assembleResp.encoded_instruction;
        #ifdef PROD
        instCache.Store(i*4, stored_data);
        #else
        memory.at(i*4) = stored_data;
        #endif

        // Operand assertion
        if (assembleResp.opeAssert != OK && curinst.opcode != Lui && curinst.opcode != Ori) {
            if (assembleResp.opeAssert == ImmOverflow || assembleResp.opeAssert == ImmOmission) {
                std::cout << "\t\033[33m[warning]\033[m ";
                if (curinst.filenameIdx == -1) std::cout << "entrypoint, line " << curinst.line << "\t";
                else std::cout << input_files[curinst.filenameIdx] << ", line " << curinst.line << "\t";
                globalfun::print_inst(stdout, curinst);
                std::cout << "\t";
                if (assembleResp.opeAssert == ImmOverflow) std::cout << "Immediate value is out of range" << std::endl;
                else if (assembleResp.opeAssert == ImmOmission) std::cout << "Immediate value is ommitted during assembling" << std::endl;
            }
            else {
                std::cout << "\t\033[31m[error]\033[m ";
                if (curinst.filenameIdx == -1) std::cout << "entrypoint, line " << curinst.line << "\t";
                else std::cout << input_files[curinst.filenameIdx] << ", line " << curinst.line << "\t";
                globalfun::print_inst(stdout, curinst);
                std::cout << "\t";
                if (assembleResp.opeAssert == Reg0Err) std::cout << "Reg0 is not between 0 - 31" << std::endl;
                else if (assembleResp.opeAssert == Reg1Err) std::cout << "Reg1 is not between 0 - 31" << std::endl;
                else if (assembleResp.opeAssert == Reg2Err) std::cout << "Reg2 is not between 0 - 31" << std::endl;
                else if (assembleResp.opeAssert == MemoryOutOfRange) std::cout << "PC is out of memory" << std::endl;
            }
        }
    }

    // for last loop
    globalfun::print_binary_bin(111, 4);
    binary.close();
    
    fprintf(fp, "0000006f\n");
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

#if defined STATS || defined PROD
inline void Program::print_stats() {
    std::cout << "<<< stats printing started..." << std::endl;

    FILE *fp = fopen((path + "/stats.txt").c_str(), "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening ./files/****/stats.txt.\n" << std::endl;
        exit(1);
    }    

    #ifdef PROD
    fprintf(fp, "<<< time prediction\n");
    TimePredict time_predict = TimePredict(
                        (long double)clock_cycle,
                        (long double)counter,
                        &instCache,
                        &dataCache,
                        &branchPrediction,
                        &stats,
                        fp);

    time_predict.predict();
    #endif

    #ifdef STATS
    // instruction stats
    std::vector<std::pair<long long int, Opcode>> instr_counter;
    for(int i = 0; i < stats_siz; i++) {
        if (opcode_to_string.count((Opcode)i)) {
            instr_counter.push_back({stats[i], (Opcode)i});
        }
    }
    std::sort(instr_counter.begin(), instr_counter.end(), std::greater<>());
    fprintf(fp, "\n<<< instruction stats\n");
    fprintf(fp, "\ttotal: \t%s\n", Program::print_int_with_comma(counter).c_str());
    for(auto i: instr_counter) {
        fprintf(fp, "\t%s: \t%s\n", opcode_to_string[i.second].c_str(), Program::print_int_with_comma(i.first).c_str());
    }
    #endif 

    #ifdef PROD
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
    branchPrediction.printStats(fp);
    #endif

    #ifdef STATS
    // labels
    std::vector<std::string> labelvector;
    for(auto i: labels) {
        labelvector.emplace_back(i.first);
    }
    #endif 

    fclose(fp);
    std::cout << "<<< stats printing finished\n" << std::endl;
}
#endif

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

inline void Program::exec() {
    std::cout << "<<< program execution started..." << std::endl; 


    #ifdef STATS
    long long int counter_size = instructions.size()*4;
    #endif

    output.open(path + "/output.bin", std::ios::out|std::ios::binary|std::ios::trunc); 
    if (!output) {
        std::cerr << "error: an error occurred opening ./files/****/output.bin";
        exit(1);
    }

    FILE *fp = fopen((path + "/output.ppm").c_str(), "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening ./****/output.ppm.\n" << std::endl;
        exit(1);
    }

    struct timespec start, end;

    // initialization
    std::cout << "\n\033[32m[log]\033[m " << print_int_with_comma(instructions.size()) << " commands (" << print_int_with_comma(instructions.size() * 4) << " bytes)\n" << std::endl;
    Program::init_source();

    clock_gettime(CLOCK_REALTIME, &start);

    // exec
    while(pc != end_point) {
        unsigned int pc_prev = pc;
        curinst = instructions[pc/4];
        Opcode opcode = curinst.opcode;

        #ifdef PROD
        // inst-cache
        instCache.Load(pc);
        instCache.clocks_from_last_sw += 1;
        dataCache.clocks_from_last_sw += 1;
        #endif


        switch(opcode) {
            case Add: xregs[curinst.reg0] = xregs[curinst.reg1] + xregs[curinst.reg2]; pc+=4; break;
            case Sub: xregs[curinst.reg0] = xregs[curinst.reg1] - xregs[curinst.reg2]; pc+=4; break;
            case Slt: if (xregs[curinst.reg1] < xregs[curinst.reg2]) {xregs[curinst.reg0] = 1;} else {xregs[curinst.reg0] = 0;}; pc+=4; break;
            case Mul: xregs[curinst.reg0] = xregs[curinst.reg1] * xregs[curinst.reg2]; pc+=4; break;
            case Div: xregs[curinst.reg0] = xregs[curinst.reg1] / xregs[curinst.reg2]; pc+=4; break;

            case Fadd: {
                #ifdef PROD
                U f1, f2;
                f1.f = fregs[curinst.reg1];
                f2.f = fregs[curinst.reg2];
                fregs[curinst.reg0] = fpu.fadd(f1, f2).f; pc += 4; break;
                #else
                fregs[curinst.reg0] = fregs[curinst.reg1] + fregs[curinst.reg2]; pc+=4; break;
                #endif
            }
            case Fsub: {
                #ifdef PROD
                U f1, f2;
                f1.f = fregs[curinst.reg1];
                f2.f = fregs[curinst.reg2];
                fregs[curinst.reg0] = fpu.fsub(f1, f2).f; pc += 4; break;
                #else
                fregs[curinst.reg0] = fregs[curinst.reg1] - fregs[curinst.reg2]; pc+=4; break;
                #endif
            }
            case Fmul: {
                #ifdef PROD
                U f1, f2;
                f1.f = fregs[curinst.reg1];
                f2.f = fregs[curinst.reg2];
                fregs[curinst.reg0] = fpu.fmul(f1, f2).f; pc += 4; break;
                #else
                fregs[curinst.reg0] = fregs[curinst.reg1] * fregs[curinst.reg2]; pc+=4; break;
                #endif
            }
            case Fdiv: {
                #ifdef PROD
                U f1, f2;
                f1.f = fregs[curinst.reg1];
                f2.f = fregs[curinst.reg2];
                fregs[curinst.reg0] = fpu.fdiv(f1, f2).f; pc += 4; break;
                #else
                fregs[curinst.reg0] = fregs[curinst.reg1] / fregs[curinst.reg2]; pc+=4; break;
                #endif
            }

            case Feq: {
                #ifdef PROD
                U f0, f1;
                f0.f = fregs[curinst.reg0];
                f1.f = fregs[curinst.reg1];
                if (fpu.feq(f0, f1)) {pc += curinst.imm;} else {pc += 4;} break;
                #else
                if (fregs[curinst.reg0] == fregs[curinst.reg1]) {pc += curinst.imm;} else {pc+=4;} break;
                #endif
            }
            case Fle: {
                #ifdef PROD
                U f0, f1;
                f0.f = fregs[curinst.reg0];
                f1.f = fregs[curinst.reg1];
                if (fpu.fle(f0, f1)) {pc += curinst.imm;} else {pc += 4;} break;
                #else
                if (fregs[curinst.reg0] <= fregs[curinst.reg1]) {pc += curinst.imm;} else {pc+=4;} break;
                #endif
            }
            case Flw: {
                int addr = xregs[curinst.reg1] + curinst.imm;
                if (addr == -1) {
                    fregs[curinst.reg0] = std_input.at(stdin_cnt).f;
                    stdin_cnt++;
                }
                else {
                    Program::check_load(addr, pc);

                    #ifdef PROD
                    fregs[curinst.reg0] = dataCache.Load(addr).f;
                    #else
                    fregs[curinst.reg0] = memory.at(addr).f; 
                    #endif
                }
                pc+=4; break;
            }
            case Fsw: {   
                int addr = xregs[curinst.reg1] + curinst.imm;
                Program::check_store(addr, pc);

                #ifdef PROD
                U stored_data;
                stored_data.f = fregs[curinst.reg0];
                dataCache.Store(addr, stored_data);
                #else
                memory.at(addr).f = fregs[curinst.reg0];
                #endif
                pc+=4; break;
            }
            case Fsqrt: {
                #ifdef PROD
                U f1;
                f1.f = fregs[curinst.reg1];
                fregs[curinst.reg0] = fpu.fsqrt(f1).f; pc += 4; break;
                #else
                fregs[curinst.reg0] = sqrt(fregs[curinst.reg1]); pc+=4; break;
                #endif
            }

            case Addi: xregs[curinst.reg0] = xregs[curinst.reg1] + curinst.imm; pc+=4; break;
            case Ori: xregs[curinst.reg0] = xregs[curinst.reg1] | (int)(std::bitset<12>(curinst.imm).to_ulong()); pc+=4; break;
            case Jalr: xregs[curinst.reg0] = pc+4; pc = xregs[curinst.reg1] + curinst.imm; break;
            case Lw: {
                int addr = xregs[curinst.reg1] + curinst.imm;
                if (addr == -1) {
                    xregs[curinst.reg0] = std_input.at(stdin_cnt).i;
                    stdin_cnt++;
                }
                else {
                    Program::check_load(addr, pc);

                    #ifdef PROD
                    xregs[curinst.reg0] = (int)dataCache.Load(addr).i;
                    #else
                    xregs[curinst.reg0] = (int)memory.at(addr).i;
                    #endif
                }
                pc += 4; break;
            }
            case Sw: {
                int addr = xregs[curinst.reg1] + curinst.imm;
                if (addr == -1) {
                    globalfun::print_output_bin(xregs[curinst.reg0], 4);
                    fprintf(fp, "%d", xregs[curinst.reg0]);
                }
                else if (addr == -2) {
                    globalfun::print_output_bin(xregs[curinst.reg0], 1);
                    fprintf(fp, "%c", (char)xregs[curinst.reg0]);
                }
                else {
                    Program::check_store(addr, pc);

                    #ifdef PROD
                    U stored_data;
                    stored_data.i = (unsigned int)xregs[curinst.reg0];
                    dataCache.Store(addr, stored_data);
                    #else
                    memory.at(addr).i = (unsigned int)xregs[curinst.reg0];
                    #endif
                }
                pc+=4; break;
            }

            case Beq: if (xregs[curinst.reg0] == xregs[curinst.reg1]) {pc += curinst.imm;} else {pc+=4;} break;
            case Ble: if (xregs[curinst.reg0] <= xregs[curinst.reg1]) { pc += curinst.imm; } else {pc+=4;} break;
            case Bge: if (xregs[curinst.reg0] >= xregs[curinst.reg1]) {pc += curinst.imm;} else {pc+=4;} break;
            case Jal: xregs[curinst.reg0] = pc + 4; pc += curinst.imm; break;
            case Lui: xregs[curinst.reg0] = (curinst.imm >> 12) << 12; pc+=4; break;

            case Arrlw: {
                int addr = xregs[curinst.reg1] + curinst.imm;

                Program::check_load(addr, pc);

                #ifdef PROD
                xregs[curinst.reg0] = (int)dataCache.Load(addr).i;
                #else
                xregs[curinst.reg0] = (int)memory.at(addr).i;
                #endif
                pc += 4; break;
            }
            case Arrsw: {
                int addr = xregs[curinst.reg1] + curinst.imm;

                Program::check_store(addr, pc);

                #ifdef PROD
                U stored_data;
                stored_data.i = (unsigned int)xregs[curinst.reg0];
                dataCache.Store(addr, stored_data);
                #else
                memory.at(addr).i = (unsigned int)xregs[curinst.reg0];
                #endif
                pc+=4; break;
            }
            case Arrflw: {
                int addr = xregs[curinst.reg1] + curinst.imm;

                if (addr == -1) {
                    fregs[curinst.reg0] = std_input.at(stdin_cnt).f;
                    stdin_cnt++;
                }
                else {
                    Program::check_load(addr, pc);

                    #ifdef PROD
                    fregs[curinst.reg0] = dataCache.Load(addr).f;
                    #else
                    fregs[curinst.reg0] = memory.at(addr).f; 
                    #endif
                }
                pc+=4; break;
            }
            case Arrfsw: {
                int addr = xregs[curinst.reg1] + curinst.imm;

                Program::check_store(addr, pc);

                #ifdef PROD
                U stored_data;
                stored_data.f = fregs[curinst.reg0];
                dataCache.Store(addr, stored_data);
                #else
                memory.at(addr).f = fregs[curinst.reg0];
                #endif
                pc+=4; break;
            }

            default: {
                if (curinst.filenameIdx == -1) std::cout << "\t" << "entrypoint, line " << curinst.line << std::endl;
                else std::cout << "\t" << input_files[curinst.filenameIdx] << ", line " << curinst.line << std::endl;
                std::cout << "\t";
                globalfun::print_inst(stdout, curinst);
                std::cout << "\n\n";
                globalfun::print_regs(binflag);
                std::cout << "\n\tcurrent pc = " << pc << "(" << std::hex << pc << std::dec << ")" << std::endl;
                std::cerr << "error: this is data section" << std::endl;
                exit(1);
            }
        }

        xregs[0] = 0;

        #ifdef DEBUG
        if ((curinst.breakpoint || brkallflag) && !brknonflag) {
            std::cout << "\tcounter = " << counter << std::endl;
            if (curinst.filenameIdx == -1) std::cout << "\t" << "entrypoint, line " << curinst.line << std::endl;
            else std::cout << "\t" << input_files[curinst.filenameIdx] << ", line " << curinst.line << std::endl;
            std::cout << "\t";
            globalfun::print_inst(stdout, curinst);
            std::cout << "\n\n";
            globalfun::print_regs(binflag);
            std::cout << "\n\tcurrent pc = " << pc << "(" << std::hex << pc << std::dec << ")" << std::endl;

            std::cout << "\n<<< PRESS ENTER" << std::endl;

            getchar();
        }
        #endif

        // check next pc
        check_load(pc, pc);

        #ifdef STATS
        stats[curinst.opcode]++;
        #endif 

        #ifdef PROD
        if (!branchPrediction.update(pc_prev, pc)) dataCache.clocks_from_last_sw += 2;
        #endif

        counter++;

        if (counter%(long long int)100000000 == 0) {
            std::cout << "<<< executed " << print_int_with_comma(counter) << " instructions" << std::endl;
        }
    }

    clock_gettime(CLOCK_REALTIME, &end);

    #ifdef DEBUG
    output.close();
    #endif
    fclose(fp);

    globalfun::print_regs(binflag);
    
    std::cout << "\telapsed time: " << (end.tv_sec + end.tv_nsec*1.0e-9) - (start.tv_sec + start.tv_nsec*1.0e-9) << "\n";
    std::cout << "\tcounter: " << Program::print_int_with_comma(counter) << '\n' << std::endl;

    std::cout << "<<< program finished\n" << std::endl;

    #if defined STATS || defined PROD
    Program::print_stats();
    #endif
}