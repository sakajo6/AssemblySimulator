#include "./fpu_check.hpp"

int main() {
    int N;
    std::cin >> N;

    FPU_check fpu_check;

    fpu_check.fadd(N);
    fpu_check.fsub(N);
    fpu_check.fmul(N);
    fpu_check.finv();
    fpu_check.fsqrt();
}