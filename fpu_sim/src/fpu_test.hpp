#include <cfloat>
#include <utility>
#include <iomanip>
#include <cmath>
#include <math.h>
#include <string>
#include <cassert>

#include "./fpu.hpp"


// sin, cos, atan, itof, ftoi, floorについてはソフトウェア実装

class FPU_test {
    private:
        FPU fpu;

        long double bin_p_127;
        long double bin_m_126;
        long double bin_m_20;
        long double bin_m_22;
        long double bin_m_23;

        U float_gen();                      

        void error1(std::string, U, U, U);     
        void error2(std::string, U, U, U, U);     

        std::pair<bool, U> spec_fadd(U, U, U);
        std::pair<bool, U> spec_fsub(U, U, U);
        std::pair<bool, U> spec_fmul(U, U, U);
        std::pair<bool, U> spec_fdiv(U, U, U);
        std::pair<bool, U> spec_finv(U, U);    
        std::pair<bool, U> spec_fsqrt(U, U);   

    public: 
        FPU_test() {
            std::cout << std::setprecision(25) << std::endl;

            bin_p_127 = pow((long double)2.0, (long double)127);
            bin_m_126 = pow((long double)2.0, (long double)(-126));
            bin_m_20 = pow((long double)2.0, (long double)(-20));
            bin_m_22 = pow((long double)2.0, (long double)(-22));
            bin_m_23 = pow((long double)2.0, (long double)(-23));
        }
        void fadd(int);
        void fsub(int);     
        void fmul(int);  
        void finv();    
        void fdiv(int);   
        void fsqrt();     
};

inline void FPU_test::error1(std::string s, U x, U z, U w) {
    std::cout << "[error] " << s << std::endl;
    std::cout << "    " << std::bitset<32>(x.i) << std::endl;
    std::cout << "    " << std::bitset<32>(z.i) << std::endl;
    std::cout << "    " << std::bitset<32>(w.i) << std::endl;

    exit(1);
}

inline void FPU_test::error2(std::string s, U x, U y, U z, U w) {
    std::cout << "[error] " << s << std::endl;
    std::cout << "    " << std::bitset<32>(x.i) << " " << x.f << std::endl;
    std::cout << "    " << std::bitset<32>(y.i) << " " << y.f << std::endl;
    std::cout << "    " << std::bitset<32>(z.i) << " " << z.f << std::endl;
    std::cout << "    " << std::bitset<32>(w.i) << " " << w.f << std::endl;
    
    exit(1);
}

inline U FPU_test::float_gen() {
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

inline std::pair<bool, U> FPU_test::spec_fadd(U x_u, U y_u, U z_u) {
    long double x = (long double)x_u.f;
    long double y = (long double)y_u.f;

    long double z = (long double)z_u.f;

    long double r = x + y;

    U w;
    w.f = (float)r;

    if (x <= -bin_p_127 || bin_p_127 <= x
        || y <= -bin_p_127 || bin_p_127 <= y
        || r <= -bin_p_127 || bin_p_127 <= r) return std::make_pair(true, w);

    long double d = fabs(z - r);
    if (d < fabs(x)*bin_m_23 
        || d < fabs(y)*bin_m_23
        || d < fabs(r)*bin_m_23
        || d < bin_m_126) return std::make_pair(true, w);

    return std::make_pair(false, w);
}

inline std::pair<bool, U> FPU_test::spec_fsub(U x_u, U y_u, U z_u) {
    long double x = (long double)x_u.f;
    long double y = (long double)y_u.f;

    long double z = (long double)z_u.f;

    long double r = x - y;

    U w;
    w.f = (float)r;

    if (x <= -bin_p_127 || bin_p_127 <= x
        || y <= -bin_p_127 || bin_p_127 <= y
        || r <= -bin_p_127 || bin_p_127 <= r) return std::make_pair(true, w);

    long double d = fabs(z - r);
    if (d < fabs(x)*bin_m_23 
        || d < fabs(y)*bin_m_23
        || d < fabs(r)*bin_m_23
        || d < bin_m_126) return std::make_pair(true, w);

    return std::make_pair(false, w);
}

inline std::pair<bool, U> FPU_test::spec_fmul(U x_u, U y_u, U z_u) {
    long double x = (long double)x_u.f;
    long double y = (long double)y_u.f;

    long double z = (long double)z_u.f;

    long double r = x * y;

    U w;
    w.f = (float)r;

    if (x <= -bin_p_127 || bin_p_127 <= x
        || y <= -bin_p_127 || bin_p_127 <= y
        || r <= -bin_p_127 || bin_p_127 <= r) return std::make_pair(true, w);

    long double d = fabs(z - r);
    if (d < fabs(r)*bin_m_22
        || d < bin_m_126) return std::make_pair(true, w);

    return std::make_pair(false, w);
}

inline std::pair<bool, U> FPU_test::spec_finv(U x_u, U z_u) {
    long double x = (long double)x_u.f;

    long double z = (long double)z_u.f;

    long double r = 1.0 / x;

    U w;
    w.f = (float)r;

    if (x <= -bin_p_127 || bin_p_127 <= x
        || r <= -bin_p_127 || bin_p_127 <= r) return std::make_pair(true, w);

    long double d = fabs(z - r);
    if (d < fabs(r)*bin_m_20
        || d < bin_m_126) return std::make_pair(true, w);

    return std::make_pair(false, w);
}

inline std::pair<bool, U> FPU_test::spec_fdiv(U x_u, U y_u, U z_u) {
    long double x = (long double)x_u.f;
    long double y = (long double)y_u.f;

    long double z = (long double)z_u.f;

    long double r = x / y;

    U w;
    w.f = (float)r;

    if (x <= -bin_p_127 || bin_p_127 <= x
        || y <= -bin_p_127 || bin_p_127 <= y
        || r <= -bin_p_127 || bin_p_127 <= r) return std::make_pair(true, w);

    long double d = fabs(z - r);
    if (d < fabs(r)*bin_m_20
        || d < bin_m_126) return std::make_pair(true, w);

    return std::make_pair(false, w);
}

inline std::pair<bool, U> FPU_test::spec_fsqrt(U x_u, U z_u) {
    long double x = (long double)x_u.f;

    long double z = (long double)z_u.f;

    long double r = sqrt(x);

    U w;
    w.f = (float)r;

    if (x <= -bin_p_127 || bin_p_127 <= x
        || r <= -bin_p_127 || bin_p_127 <= r) return std::make_pair(true, w);

    long double d = fabs(z - r);
    if (d < fabs(r)*bin_m_20
        || d < bin_m_126) return std::make_pair(true, w);

    return std::make_pair(false, w);
}

inline void FPU_test::fadd(int N) {
    std::cout << "[log] fadd test started" << std::endl;

    U x, y, z, w;
    bool flag;
    std::pair<bool, U> ret;

    // x != 0 && y != 0
    for (int i = 0; i < N; i++) {
        x = float_gen();
        y = float_gen();
        z = fpu.fadd(x, y);

        ret = spec_fadd(x, y, z);
        flag = ret.first;
        w = ret.second;
        if (!flag) {
            error2("fadd: 0", x, y, z, w);
        }
    }

    // x == 0 && y != 0
    for (int i = 0; i < N; i++) {
        x.i = 0;
        y = float_gen();
        z = fpu.fadd(x, y);

        ret = spec_fadd(x, y, z);
        flag = ret.first;
        w = ret.second;
        if (!flag) {
            error2("fadd: 1", x, y, z, w);
        }
    }

    // x != 0 && y == 0
    for (int i = 0; i < N; i++) {
        x = float_gen();
        y.i = 0;
        z = fpu.fadd(x, y);

        ret = spec_fadd(x, y, z);
        flag = ret.first;
        w = ret.second;
        if (!flag) {
            error2("fadd: 2", x, y, z, w);
        }
    }

    std::cout << "[log] fadd test passed!!" << std::endl;
}

inline void FPU_test::fsub(int N) {
    std::cout << "[log] fsub test started" << std::endl;

    U x, y, z, w;
    bool flag;
    std::pair<bool, U> ret;

    // x != 0 && y != 0
    for (int i = 0; i < N; i++) {
        x = float_gen();
        y = float_gen();
        z = fpu.fsub(x, y);

        ret = spec_fsub(x, y, z);
        flag = ret.first;
        w = ret.second;
        if (!flag) {
            error2("fsub: 0", x, y, z, w);
        }
    }

    // x == 0 && y != 0
    for (int i = 0; i < N; i++) {
        x.i = 0;
        y = float_gen();
        z = fpu.fsub(x, y);

        ret = spec_fsub(x, y, z);
        flag = ret.first;
        w = ret.second;
        if (!flag) {
            error2("fsub: 1", x, y, z, w);
        }
    }

    // x != 0 && y == 0
    for (int i = 0; i < N; i++) {
        x = float_gen();
        y.i = 0;
        z = fpu.fsub(x, y);

        ret = spec_fsub(x, y, z);
        flag = ret.first;
        w = ret.second;
        if (!flag) {
            error2("fsub: 2", x, y, z, w);
        }
    }

    std::cout << "[log] fsub test passed!!" << std::endl;
}

inline void FPU_test::fmul(int N) {
    std::cout << "[log] fmul test started" << std::endl;

    U x, y, z, w;
    bool flag;
    std::pair<bool, U> ret;

    // x != 0 && y != 0
    for (int i = 0; i < N; i++) {
        x = float_gen();
        y = float_gen();
        z = fpu.fmul(x, y);

        ret = spec_fmul(x, y, z);
        flag = ret.first;
        w = ret.second;
        if (!flag) {
            error2("fmul: 0", x, y, z, w);
        }
    }

    // x == 0 && y != 0
    for (int i = 0; i < N; i++) {
        x.i = 0;
        y = float_gen();
        z = fpu.fmul(x, y);

        ret = spec_fmul(x, y, z);
        flag = ret.first;
        w = ret.second;
        if (!flag) {
            error2("fmul: 1", x, y, z, w);
        }
    }

    // x != 0 && y == 0
    for (int i = 0; i < N; i++) {
        x = float_gen();
        y.i = 0;
        z = fpu.fmul(x, y);

        ret = spec_fmul(x, y, z);
        flag = ret.first;
        w = ret.second;
        if (!flag) {
            error2("fmul: 2", x, y, z, w);
        }
    }

    std::cout << "[log] fmul test passed!!" << std::endl;
}

inline void FPU_test::finv() {
    std::cout << "[log] finv test started" << std::endl;

    U x, z, w;
    bool flag;
    std::pair<bool, U> ret;

    // inspect all
    // x != 0
    for (unsigned int s = 0; s < 2; s++) {
        for (unsigned int e = 1; e < 255; e++) {
            for (unsigned int m = 0; m < (1 << 23); m++) {
                x.i = (s << 31) + (e << 23) + m;
                z = fpu.finv(x);

                ret = spec_finv(x, z);
                flag = ret.first;
                w = ret.second;
                if (!flag) {
                    error1("finv", x, z, w);
                }
            }
        }
    }

    std::cout << "[log] finv test passed" << std::endl;
}

inline void FPU_test::fdiv(int N) {
    std::cout << "[log] fdiv test started" << std::endl;

    U x, y, z, w;
    bool flag;
    std::pair<bool, U> ret;

    // x != 0 && y != 0
    for (int i = 0; i < N; i++) {
        x = float_gen();
        y = float_gen();
        z = fpu.fdiv(x, y);

        ret = spec_fdiv(x, y, z);
        flag = ret.first;
        w = ret.second;
        if (!flag) {
            error2("fdiv: 0", x, y, z, w);
        }
    }

    // x == 0 && y != 0
    for (int i = 0; i < N; i++) {
        x.i = 0;
        y = float_gen();
        z = fpu.fdiv(x, y);

        ret = spec_fdiv(x, y, z);
        flag = ret.first;
        w = ret.second;
        if (!flag) {
            error2("fdiv: 1", x, y, z, w);
        }
    }

    std::cout << "[log] fdiv test passed" << std::endl;
}

inline void FPU_test::fsqrt() {
    std::cout << "[log] fsqrt test started" << std::endl;

    U x, z, w;
    bool flag;
    std::pair<bool, U> ret;

    // inspect all
    // x >= 0
    unsigned int s = 0;
    for (unsigned int e = 1; e < 255; e++) {
        for (unsigned int m = 0; m < (1 << 23); m++) {
            x.i = (s << 31) + (e << 23) + m;
            z = fpu.fsqrt(x);

            ret = spec_fsqrt(x, z);
            flag = ret.first;
            w = ret.second;
            if (!flag) {
                error1("fsqrt: 0", x, z, w);
            }
        }
    }

    // x = 0
    x.i = 0;
    z = fpu.fsqrt(x);

    ret = spec_fsqrt(x, z);
    flag = ret.first;
    w = ret.second;
    if (!flag) {
        error1("fsqrt: 1", x, z, w);
    }

    std::cout << "[log] fsqrt test passed" << std::endl;
}