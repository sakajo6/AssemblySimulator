#include "./fpu_test.hpp"

int main() {
    int N;
    std::cin >> N;

    FPU_test fpu_test;

    fpu_test.fadd_test(N);
    fpu_test.fsub_test(N);
    fpu_test.fmul_test(N);
    // fpu_test.finv_test();
    fpu_test.fdiv_test(N);
    // fpu_test.fsqrt_test();
}