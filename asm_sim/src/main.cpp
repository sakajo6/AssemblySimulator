#include <stdio.h>
#include <fstream>
#include <iomanip>

#include "program.hpp"
#include "global.hpp"

int main(int argc, char const *argv[]) {
    std::cout << std::fixed << std::setprecision(10);

    // input files
    std::string input_folder;
    std::cout << "<<< please input folder name" << std::endl;
    std::cout << "./files/";
    std::cin >> input_folder;
    getchar();

    // path for input folder
    path = "./files/" + input_folder;

    Program program;
    program.callReader(argc, argv);
    program.callAssembler();
    program.exec();

    return 0;
}