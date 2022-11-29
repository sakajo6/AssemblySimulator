#pragma once

#include <vector>
#include <string>
#include <map>
#include <algorithm>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <thread>
#include <tuple>

#include "sim_instruction.hpp"
#include "sim_opecode.hpp"
#include "sim_global.hpp"
#include "sim_reader.hpp"
#include "sim_assembler.hpp"
#include "sim_cache.hpp"


class Program {
    private:
        int pc;
        long long int counter;

        std::vector<Instruction> instructions;
        int sld_datacnt;
        int end_point;

        std::vector<long long int> stats; 

        Cache instCache;
        Cache dataCache;

        void init_source();
        std::string print_int_with_comma(long long int);
        void print_stats();

    public:
        Program(int argc, char const *argv[]) {
            pc = 0;
            counter = 0;

            Reader reader;
            std::tie(instructions, sld_datacnt, end_point) = reader.read_inputs(argc, argv);

            Assembler assembler;
            assembler.assemble(instructions);

            instCache = Cache(25, 3, 4, 2);
            dataCache = Cache(25, 3, 4, 2);

            stats.assign(100, (long long int)0);
        }
        void exec();
};

inline std::string Program::print_int_with_comma(long long int n) {
	std::string result=std::to_string(n);
		for(int i=result.size()-3; i>0;i-=3)
			result.insert(i,",");
		return result;		
}

inline void Program::print_stats() {
    std::cout << "<<< stats printing started..." << std::endl;

    FILE *fp = fopen("./output/stats.txt", "w");
    if (fp == NULL) {
        std::cerr << "error: an error occurred opening ./output/stats.txt.\n" << std::endl;
        exit(1);
    }    

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

    #ifdef TEST
    fprintf(fp, "\n<<< cache stats\n");
    // inst-cache
    fprintf(fp, "\tinst-cache: \t%lf\n", instCache.printHitRate());
    // data-cache
    fprintf(fp, "\tdata-cache: \t%lf\n", dataCache.printHitRate());

    // branch prediction
    #endif

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

    pc = 0;
    while(pc != end_point) {
        Instruction curinst = instructions[pc/4];

        #ifdef TEST
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
        #endif

        pc = curinst.exec(fp, pc);

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

