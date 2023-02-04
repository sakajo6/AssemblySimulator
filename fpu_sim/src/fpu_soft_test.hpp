#include <cfloat>
#include <utility>
#include <iomanip>
#include <cmath>
#include <math.h>
#include <time.h>
#include <string>
#include <cassert>

#include <unistd.h>

#include "./fpu_soft.hpp"


// sin, cos, atan, itof, ftoi, floorについてはソフトウェア実装

class FPU_soft_test {
    private:
        FPU_soft fpu;

        long double pi;
        long double c;
        long double bin_p_31;
        long double bin_p_127;
        long double bin_m_126;
        long double bin_m_18;
        long double bin_m_20;
        long double bin_m_22;
        long double bin_m_23;

        U float_gen();                      

        void error1(std::string, U, U, U);     
        void error2(std::string, U, U, U, U);     

        void spec_sin(U, U);
        void spec_cos(U, U);
        void spec_atan(U, U);
        void spec_floor(U, U);
        void spec_ftoi(U, U);
        void spec_itof(U, U);

    public: 
        FPU_soft_test() {
            srand(time(NULL));
            std::cout << std::setprecision(25) << std::endl;

            pi = 3.1415926535897932384626433832795028841971;
            c = pi / float(pi);
            bin_p_31 = pow((long double)2.0, (long double)31);
            bin_p_127 = pow((long double)2.0, (long double)127);
            bin_m_126 = pow((long double)2.0, (long double)(-126));
            bin_m_18 = pow((long double)2.0, (long double)(-18));
            bin_m_20 = pow((long double)2.0, (long double)(-20));
            bin_m_22 = pow((long double)2.0, (long double)(-22));
            bin_m_23 = pow((long double)2.0, (long double)(-23));
        }

        void sin_test(int);
        void cos_test(int);
        void atan_test(); 
        void floor_test(int);
        void ftoi_test(int);
        void itof_test(int);
};

inline void FPU_soft_test::error1(std::string s, U x, U z, U w) {
    std::cout << "[error] " << s << std::endl;
    std::cout << "    " << std::bitset<32>(x.i) << " " << x.f << std::endl;
    std::cout << "    " << std::bitset<32>(z.i) << " " << z.f << std::endl;
    std::cout << "    " << std::bitset<32>(w.i) << " " << w.f << std::endl;

    // exit(1);
}

inline void FPU_soft_test::error2(std::string s, U x, U y, U z, U w) {
    std::cout << "[error] " << s << std::endl;
    std::cout << "    " << std::bitset<32>(x.i) << " " << x.f << std::endl;
    std::cout << "    " << std::bitset<32>(y.i) << " " << y.f << std::endl;
    std::cout << "    " << std::bitset<32>(z.i) << " " << z.f << std::endl;
    std::cout << "    " << std::bitset<32>(w.i) << " " << w.f << std::endl;
    
    // exit(1);
}

inline U FPU_soft_test::float_gen() {
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

inline void FPU_soft_test::spec_sin(U x_u, U z_u) {
    long double x = (long double)x_u.f;
    long double z = (long double)z_u.f;
    long double r = sin(c*x);

    U w;
    w.f = (float)r;

    if (x <= -bin_p_127 || bin_p_127 <= x) return;

    long double d = fabs(z - r);
    if (d < fabs(r)*bin_m_18 || d < bin_m_126) return;

    error1("sin: ", x_u, z_u, w);

    return;
}

inline void FPU_soft_test::spec_cos(U x_u, U z_u) {
    long double x = (long double)x_u.f;
    long double z = (long double)z_u.f;
    long double r = cos(c*x);

    U w;
    w.f = (float)r;

    if (x <= -bin_p_127 || bin_p_127 <= x) return;

    long double d = fabs(z - r);
    if (d < fabs(r)*bin_m_18 || d < bin_m_126) return;

    error1("cos: ", x_u, z_u, w);

    return;
}

inline void FPU_soft_test::spec_atan(U x_u, U z_u) {
    long double x = (long double)x_u.f;
    long double z = (long double)z_u.f;
    long double r = atan(x);

    U w;
    w.f = (float)r;

    if (x <= -bin_p_127 || bin_p_127 <= x) return;

    long double d = fabs(z - r);
    if (d < fabs(r)*bin_m_20 || d < bin_m_126) return;

    error1("atan: ", x_u, z_u, w);

    return;
}

inline void FPU_soft_test::spec_floor(U x_u, U z_u) {
    long double x = (long double)x_u.f;
    long double z = (long double)z_u.f;
    long double r = floor(x);

    U w;
    w.f = (float)r;

    if (x <= -bin_p_127 || bin_p_127 <= x) return;

    if (z == r && z <= x && x < z + 1.0) return;

    error1("floor: ", x_u, z_u, w);

    return;
}

inline void FPU_soft_test::spec_ftoi(U x_u, U z_u) {
    long double x = (long double)x_u.f; // float
    long double z = (long double)((int)z_u.i); // unsigned int
    long double r = (int)(x);

    U w;
    w.f = (float)r;

    if (x < -bin_p_31 + 1.0 || bin_p_31 - 1 < x) return;

    long double d = z - 1.0;
    for(int i = 0; i < 2; i++) { 
        if (fabs(d - x) < fabs(z - x)) {
            z_u.f = (float)((int)z_u.i);
            error1("ftoi: ", x_u, z_u, w);
            return;
        }

        d += 1.0;
    }

    return;
}

inline void FPU_soft_test::spec_itof(U x_u, U z_u) {
    long double x = (long double)((int)x_u.i); // unsigned int
    long double z = (long double)z_u.f; // float
    long double r = (float)(x);

    U w;
    w.f = (float)r;

    for(int i = -1; i <= 1; i++) {
        U d;
        d.i = z_u.i + i;

        if (fabs(d.f - x) < fabs(z - x)) {
            x_u.f = (float)((int)x_u.i);
            error1("itof: ", x_u, z_u, w);
            return;
        }
    }

    return;
}

inline void FPU_soft_test::sin_test(int N) {
    std::cout << "[log] sin test started" << std::endl;

    U x, z;

    for (int i = 0; i < N; i++) {
        x = float_gen();
        while(fabs(x.f) >= 100.0) {
            x = float_gen();
        }
        z = fpu.sin(x);

        spec_sin(x, z);
    }

    // inspect all
    // for (unsigned int s = 0; s < 2; s++) {
    //     for (unsigned int e = 1; e < 255; e++) {
    //         for (unsigned int m = 0; m < (1 << 23); m++) {
    //             x.i = (s << 31) + (e << 23) + m;
    //             z = fpu.sin(x);

    //             spec_sin(x, z);
    //         }
    //     }
    // }

    std::cout << "[log] sin test passed!!" << std::endl;
}


inline void FPU_soft_test::cos_test(int N) {
    std::cout << "[log] cos test started" << std::endl;

    U x, z;

    for (int i = 0; i < N; i++) {
        x = float_gen();
        while(fabs(x.f) >= 100.0) {
            x = float_gen();
        }
        z = fpu.cos(x);

        spec_cos(x, z);
    }

    // // inspect all
    // for (unsigned int s = 0; s < 2; s++) {
    //     for (unsigned int e = 1; e < 255; e++) {
    //         for (unsigned int m = 0; m < (1 << 23); m++) {
    //             x.i = (s << 31) + (e << 23) + m;
    //             z = fpu.cos(x);

    //             spec_cos(x, z);
    //         }
    //     }
    // }

    std::cout << "[log] cos test passed!!" << std::endl;
}

inline void FPU_soft_test::atan_test() {
    std::cout << "[log] atan test started" << std::endl;

    U x, z;
    // inspect all
    for (unsigned int s = 0; s < 2; s++) {
        for (unsigned int e = 1; e < 255; e++) {
            for (unsigned int m = 0; m < (1 << 23); m++) {
                x.i = (s << 31) + (e << 23) + m;
                z = fpu.atan(x);

                spec_atan(x, z);
            }
        }
    }

    std::cout << "[log] atan test passed!!" << std::endl;
}

inline void FPU_soft_test::floor_test(int N) {
    std::cout << "[log] floor test started" << std::endl;

    U x, z;

    for (int i = 0; i < N; i++) {
        x = float_gen();
        while(fabs(x.f) >= 8388608.0) {
            x = float_gen();
        }
        z = fpu.floor(x);

        spec_floor(x, z);
    }

    // // inspect all
    // for (unsigned int s = 0; s < 2; s++) {
    //     for (unsigned int e = 1; e < 255; e++) {
    //         for (unsigned int m = 0; m < (1 << 23); m++) {
    //             x.i = (s << 31) + (e << 23) + m;
    //             z = fpu.floor(x);

    //             spec_floor(x, z);
    //         }
    //     }
    // }

    std::cout << "[log] floor test passed!!" << std::endl;
}

inline void FPU_soft_test::ftoi_test(int N) {
    std::cout << "[log] ftoi test started" << std::endl;

    U x, z;

    for (int i = 0; i < N; i++) {
        x = float_gen();
        while(fabs(x.f) >= 8388608.0) {
            x = float_gen();
        }
        z = fpu.ftoi(x);

        spec_ftoi(x, z);
    }

    // inspect all
    // for (unsigned int s = 0; s < 2; s++) {
    //     for (unsigned int e = 1; e < 255; e++) {
    //         for (unsigned int m = 0; m < (1 << 23); m++) {
    //             x.i = (s << 31) + (e << 23) + m;
    //             z = fpu.ftoi(x);

    //             spec_ftoi(x, z);
    //         }
    //     }
    // }

    std::cout << "[log] ftoi test passed!!" << std::endl;
}

inline void FPU_soft_test::itof_test(int N) {
    std::cout << "[log] itof test started" << std::endl;

    U x, z;

    for (int i = 0; i < N; i++) {
        x = float_gen();
        while(fabs(x.f) >= 8388608.0) {
            x = float_gen();
        }
        z = fpu.itof(x);

        spec_itof(x, z);
    }

    // inspect all
    // for (unsigned int s = 1; s < 2; s++) {
    //     for (unsigned int e = 0; e < (1 << 8); e++) {
    //         for (unsigned int m = 0; m < (1 << 23); m++) {
    //             x.i = (s << 31) + (e << 23) + m;
    //             z = fpu.itof(x);

    //             spec_itof(x, z);
    //         }
    //     }
    // }

    std::cout << "[log] itof test passed!!" << std::endl;
}