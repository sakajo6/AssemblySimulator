#include <iostream>
#include <bitset>
#include "./sim_fpu.hpp"

int main() {
    std::cout << "hello, world" << std::endl;

    FPU fpu;
    U x1, x2;
    x1.f = 12.143939;
    x2.f = 1.559393;
    std::cout << fpu.fadd(x1, x2).f << std::endl;

    x1.f = -12.143939;
    x2.f = -1.559393;
    std::cout << fpu.fadd(x1, x2).f << std::endl;

    x1.f = 12.143939;
    x2.f = -1.559393;
    std::cout << fpu.fadd(x1, x2).f << std::endl;

    x1.f = -12.143939;
    x2.f = 1.559393;
    std::cout << fpu.fadd(x1, x2).f << std::endl;
}