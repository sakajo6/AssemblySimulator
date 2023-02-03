#include "./fpu_test.hpp"
#include "./fpu_soft_test.hpp"

int main() {
    int N = 100000000;

    FPU_test fpu_test;

    // fpu_test.fadd_test(N);   // ok
    // fpu_test.fsub_test(N);   // ok
    // fpu_test.fmul_test(N);   // ok
    // fpu_test.fdiv_test(N);   // ok?
    // fpu_test.fsqrt_test();   // ng(誤差大. 2^(-12)には収まるが2^(-20)に収まる必要)

    FPU_soft_test fpu_soft_test;

    // fabs(x) < 10
    fpu_soft_test.sin_test(N);    // fabs(x) < 10 -> x +-2pi, +-4pi
    fpu_soft_test.cos_test(N);    // fabs(x) < 10 -> x +-pihalf

    fpu_soft_test.atan_test();   // ok(13次必要)

    // fabs(x) < 8388608
    fpu_soft_test.floor_test(N);  // ok(判定入れたらok)
    fpu_soft_test.ftoi_test(N);   // たぶんok(大きい数では実行時間長でテスト不可)
    fpu_soft_test.itof_test(N);   // たぶんok(大きい数では実行時間長でテスト不可)
}