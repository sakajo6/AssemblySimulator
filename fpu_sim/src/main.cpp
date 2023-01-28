#include "./fpu_check.hpp"

int main() {
    FPU_check fpu_check;

    fpu_check.fadd();
    fpu_check.fsub();
    fpu_check.fdiv();
    fpu_check.finv();
    fpu_check.fmul();
}