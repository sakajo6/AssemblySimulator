#pragma once

#include "sim_global.hpp"

class FPU {
    private:
        U finv(U);
    public:
        U fadd(U, U);
        U fsub(U, U);
        U fmul(U, U);
        U fdiv(U, U);
        U fsqrt(U);
}

inline U FPU::finv(U) {
    // fmul, fsubで計算
}

inline U FPU::fadd(U x, U y) {
    // 頑張ってエミュレート
}

inline U FPU::fsub(U x, U y) {
    // yの符号反転. faddで計算
}

inline U FPU::fmul(U x, U y) {
    // 頑張ってエミュレート
}

inline U FPU::fdiv(U x, U y) {
    // finv を用いて計算
}

inline U FPU::fsqrt(U x, U y) {

}
