#include <cfloat>
#include <cmath>
#include <string>
#include <cassert>

#include "./fpu.hpp"


// sin, cos, atan, itof, ftoi, floorについてはソフトウェア実装

class FPU_check {
    private:
        FPU fpu;

        long double bin_p_127;
        long double bin_m_126;
        long double bin_m_20;
        long double bin_m_22;
        long double bin_m_23;

        U float_gen();                      // done
        void error2(std::string, U, U);     // done
        void error3(std::string, U, U, U);  // done
        bool spec_fadd(U, U, U);            // new
        bool spec_fsub(U, U, U);            // new
        bool spec_fmul(U, U, U);            // new
        bool spec_inv(U, U);                // new
        bool spec_sqrt(U, U);               // new

    public: 
        FPU_check() {
            bin_p_127 = pow((long double)2.0, (long double)127);
            bin_m_126 = pow((long double)2.0, (long double)(-126));
            bin_m_20 = pow((long double)2.0, (long double)(-20));
            bin_m_22 = pow((long double)2.0, (long double)(-22));
            bin_m_23 = pow((long double)2.0, (long double)(-23));
        }
        void fadd(int);     // done
        void fsub(int);     // done
        void fmul(int);     // done
        void finv();        // done
        void fsqrt();       // done
        // void fdiv(int);    // new
};

inline void FPU_check::error2(std::string s, U x, U z) {
    std::cout << "[error] " << s << std::endl;
    std::cout << "    " << std::bitset<32>(x.i) << std::endl;
    std::cout << "    " << std::bitset<32>(z.i) << std::endl;
    exit(1);
}

inline void FPU_check::error3(std::string s, U x, U y, U z) {
    std::cout << "[error] " << s << std::endl;
    std::cout << "    " << std::bitset<32>(x.i) << " " << x.f << std::endl;
    std::cout << "    " << std::bitset<32>(y.i) << " " << y.f << std::endl;
    std::cout << "    " << std::bitset<32>(z.i) << " " << z.f << std::endl;
    exit(1);
}

inline U FPU_check::float_gen() {
    U ret;

    // 符号(s): 1 bit
    //  0のとき正, 1のとき負
    unsigned int s = 2 * (rand() / (RAND_MAX + 1.0));

    // 指数(e): 8 bit
    //  254 - 1:    正規化数
    //  255:        仮数部が0以外   -> NaN
    //              仮数部が0       -> 符号部が0    -> 正の無限大
    //                              -> 符号部が1    -> 負の無限大
    //  0:          非正規化数(ただし、指数部、仮数部がともに0のときは +0/-0)
    unsigned int e = ((1 << 8) - 2) * (rand() / (RAND_MAX + 1.0)); // 0 - 253
    e++;

    // 仮数(m): 23 bit
    //  ケチ表現: 1.******の形を仮定
    unsigned int m = (1 << 23) * (rand() / (RAND_MAX + 1.0));

    ret.i = (s << 31) + (e << 23) + m;

    return ret;
}

inline bool FPU_check::spec_fadd(U x_u, U y_u, U z_u) {
    long double x = (long double)x_u.f;
    long double y = (long double)y_u.f;

    long double z = (long double)z_u.f;

    long double r = x + y;

    if (x <= -bin_p_127 || bin_p_127 <= x
        || y <= -bin_p_127 || bin_p_127 <= y
        || r <= -bin_p_127 || bin_p_127 <= r) return true;

    long double d = abs(z - r);
    if (d < abs(x)*bin_m_23 
        || d < abs(y)*bin_m_23
        || d < abs(r)
        || d < bin_m_126) return true;

    return false;
}

inline bool FPU_check::spec_fsub(U x_u, U y_u, U z_u) {
    long double x = (long double)x_u.f;
    long double y = (long double)y_u.f;

    long double z = (long double)z_u.f;

    long double r = x - y;

    if (x <= -bin_p_127 || bin_p_127 <= x
        || y <= -bin_p_127 || bin_p_127 <= y
        || r <= -bin_p_127 || bin_p_127 <= r) return true;

    long double d = abs(z - r);
    if (d < abs(x)*bin_m_23 
        || d < abs(y)*bin_m_23
        || d < abs(r)
        || d < bin_m_126) return true;

    return false;
}

inline bool FPU_check::spec_fmul(U x_u, U y_u, U z_u) {
    long double x = (long double)x_u.f;
    long double y = (long double)y_u.f;

    long double z = (long double)z_u.f;

    long double r = x * y;

    if (x <= -bin_p_127 || bin_p_127 <= x
        || y <= -bin_p_127 || bin_p_127 <= y
        || r <= -bin_p_127 || bin_p_127 <= r) return true;

    long double d = abs(z - r);
    if (d < abs(r)*bin_m_22
        || d < bin_m_126) return true;

    return true;
}

inline bool FPU_check::spec_inv(U x, U y) {

    return true;
}

inline bool FPU_check::spec_sqrt(U x, U y) {

    return true;
}

inline void FPU_check::fadd(int N) {
    std::cout << "[log] fadd check started" << std::endl;

    U x, y, z;

    // x != 0 && y != 0
    for (int i = 0; i < N; i++) {
        x = float_gen();
        y = float_gen();
        z = fpu.fadd(x, y);

        if (!spec_fadd(x, y, z)) error3("fadd: 0", x, y, z);
    }

    // x == 0 && y != 0
    for (int i = 0; i < N; i++) {
        x.i = 0;
        y = float_gen();
        z = fpu.fadd(x, y);

        if (!spec_fadd(x, y, z)) error3("fadd: 1", x, y, z);
    }

    // x != 0 && y == 0
    for (int i = 0; i < N; i++) {
        x = float_gen();
        y.i = 0;
        z = fpu.fadd(x, y);

        if (!spec_fadd(x, y, z)) error3("fadd: 2", x, y, z);
    }

    std::cout << "[log] fadd check passed!!" << std::endl;
}

inline void FPU_check::fsub(int N) {
    std::cout << "[log] fsub check started" << std::endl;

    U x, y, z;

    // x != 0 && y != 0
    for (int i = 0; i < N; i++) {
        x = float_gen();
        y = float_gen();
        z = fpu.fsub(x, y);

        if (!spec_fsub(x, y, z)) error3("fsub: 0", x, y, z);
    }

    // x == 0 && y != 0
    for (int i = 0; i < N; i++) {
        x.i = 0;
        y = float_gen();
        z = fpu.fsub(x, y);

        if (!spec_fsub(x, y, z)) error3("fsub: 1", x, y, z);
    }

    // x != 0 && y == 0
    for (int i = 0; i < N; i++) {
        x = float_gen();
        y.i = 0;
        z = fpu.fsub(x, y);

        if (!spec_fsub(x, y, z)) error3("fsub: 2", x, y, z);
    }

    std::cout << "[log] fsub check passed!!" << std::endl;
}

inline void FPU_check::fmul(int N) {
    std::cout << "[log] fmul check started" << std::endl;

    U x, y, z;

    // x != 0 && y != 0
    for (int i = 0; i < N; i++) {
        x = float_gen();
        y = float_gen();
        z = fpu.fmul(x, y);

        if (!spec_fmul(x, y, z)) error3("fmul: 0", x, y, z);
    }

    // x == 0 && y != 0
    for (int i = 0; i < N; i++) {
        x.i = 0;
        y = float_gen();
        z = fpu.fmul(x, y);

        if (!spec_fmul(x, y, z)) error3("fmul: 1", x, y, z);
    }

    // x != 0 && y == 0
    for (int i = 0; i < N; i++) {
        x = float_gen();
        y.i = 0;
        z = fpu.fmul(x, y);

        if (!spec_fmul(x, y, z)) error3("fmul: 2", x, y, z);
    }

    std::cout << "[log] fmul check passed!!" << std::endl;
}

inline void FPU_check::finv() {
    std::cout << "[log] finv check started" << std::endl;

    // inspect all
    // x != 0
    U x, z;
    for (unsigned int s = 0; s < 2; s++) {
        for (unsigned int e = 1; e < 255; e++) {
            for (unsigned int m = 0; m < (1 << 23); m++) {
                x.i = (s << 31) + (e << 23) + m;
                z = fpu.finv(x);

                if (!spec_inv(x, z)) error2("finv", x, z);
            }
        }
    }

    std::cout << "[log] finv check passed" << std::endl;
}

inline void FPU_check::fsqrt() {
    std::cout << "[log] fsqrt check started" << std::endl;

    // inspect all
    // x >= 0
    U x, z;
    unsigned int s = 0;
    for (unsigned int e = 1; e < 255; e++) {
        for (unsigned int m = 0; m < (1 << 23); m++) {
            x.i = (s << 31) + (e << 23) + m;
            z = fpu.fsqrt(x);

            if (!spec_sqrt(x, z)) error2("fsqrt: 0", x, z);
        }
    }

    // x = 0
    x.i = 0;
    z = fpu.fsqrt(x);
    if (!spec_sqrt(x, z)) error2("fsqrt: 1", x, z);

    std::cout << "[log] fsqrt check passed" << std::endl;
}

// inline void FPU_check::fdiv(int N) {
//     // x != 0 && y != 0

//     // x == 0 && y != 0
// }