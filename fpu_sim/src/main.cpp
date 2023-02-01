#include "./fpu_test.hpp"
#include "./fpu_soft_test.hpp"

int main() {
    int N = 100000000;

    FPU_test fpu_test;

    // fpu_test.fadd_test(N);
    // fpu_test.fsub_test(N);
    // fpu_test.fmul_test(N);
    // fpu_test.finv_test();
    // fpu_test.fdiv_test(N);
    // fpu_test.fsqrt_test();

    FPU_soft_test fpu_soft_test;

    // fpu_soft_test.sin_test();
    // fpu_soft_test.cos_test();
    fpu_soft_test.atan_test();
}