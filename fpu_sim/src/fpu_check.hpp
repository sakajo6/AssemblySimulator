#include <cassert>

#include "./fpu.hpp"


// sin, cos, atan, itof, ftoi, floorについてはソフトウェア実装

class FPU_check {
    private:
        FPU fpu;
        bool spec_fadd_fsub(U, U);  // new
        bool spec_fmul(U, U);       // new
        bool spec_inv_sqrt(U, U);   // new

    public: 
        void fadd();    // new
        void fsub();    // new 
        void fdiv();    // new
        void finv();    // new
        void fmul();    // new
};

inline bool FPU_check::spec_fadd_fsub(U x, U y) {

    return true;
}

inline bool FPU_check::spec_fmul(U x, U y) {

    return true;
}

inline bool FPU_check::spec_inv_sqrt(U x, U y) {

    return true;
}

inline void FPU_check::fadd() {
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

inline void FPU_check::fsub() {

}

inline void FPU_check::fdiv() {

}

inline void FPU_check::finv() {

}

inline void FPU_check::fmul() {
    U x1, x2;
    x1.f = 2.5;
    x2.f = 2.5;
    std::cout << fpu.fmul(x1, x2).f << std::endl;

    x1.f = -1.234;
    x2.f = 1234;
    std::cout << fpu.fmul(x1, x2).f << std::endl;
}