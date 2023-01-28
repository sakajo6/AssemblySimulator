#include "./fpu_test.hpp"

int main() {
    int N;
    std::cin >> N;

    FPU_test fpu_test;

    fpu_test.fadd(N);
    fpu_test.fsub(N);
    fpu_test.fmul(N);
    // fpu_test.finv();
    // fpu_test.fdiv(N);
    // fpu_test.fsqrt();
}