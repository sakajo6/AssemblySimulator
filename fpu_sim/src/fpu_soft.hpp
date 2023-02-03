#pragma once

#include <iostream>
#include <bitset>

class FPU_soft {
    private:
        float pi, pi2, pihalf, piquat;

        float reduction_2pi(float);
        int reverse_flag(int);
        float sin_main(float);
        float sin(float);
        float cos_main(float);
        float cos(float);
        float atan(float);

        float floor(float);
        int int_of_float_rem(float, int);
        int int_of_float_four(float, int);
        int ftoi(float);
        float itof(int);

    public:
        FPU_soft() {
            pi = 3.1415927410125732421875;
            pi2 = pi * 2.0;
            pihalf = pi * 0.5;
            piquat = pi * 0.25;
        }
        U sin(U);
        U cos(U);
        U atan(U);
        U floor(U);
        U ftoi(U);
        U itof(U);
};

inline float FPU_soft::reduction_2pi(float x) {
    float p = pi2;
    while (x >= p) {
        p = p * 2.0;
    }
    while (x >= pi2) {
        if (x >= p) {
            x = x - p;
        }
        p = p / 2.0;
    }

    return x;
}

inline int FPU_soft::reverse_flag(int x) {
    if (x == 0) return 1;
    else return 0;
}

inline float FPU_soft::sin_main(float x) {
    float x2 = x * x;
    float x3 = x * x2;

    return  x - 0.16666668 * x3 + 0.008332824 * x2 * x3 - 0.00019587841 * x2 * x2 * x3;

    // float x2 = x * x;

    // return ((((0.0000027557319 * x2 - 0.000198412698) * x2 + 0.0083333333) * x2 - 0.166666666) * x2 + 1) * x;
}

inline float FPU_soft::cos_main(float x) {
    float x2 = x * x;
    float x4 = x2 * x2;

    return 1.0 - 0.5 * x2 + 0.04166368 * x4 - 0.0013695068 * x2 * x4;

    // float x2 = x * x;

    // return ((((-0.00000027557319223 * x2 + 0.000024801587301) * x2 + -0.00138888888) * x2 + 0.041666666) * x2 + -0.5) * x2 + 1.0;
}

inline float FPU_soft::sin(float x) {
    if (x < 0.0)            return -sin(-x);
    else if (x >= pi2)      return sin(x - pi2);
    else if (x >= pi)       return -sin(x - pi);
    else if (x > pihalf)    return sin(pi - x);
    else if (x >= piquat)   return cos_main(pihalf - x);
    else                    return sin_main(x);

    // int flag = 0;   // 0: pos, 1: neg
    // if (x < 0.0) {
    //     flag = 1;
    //     x = x * -1.0;
    // }

    // x = reduction_2pi(x);

    // if (x >= pi) {
    //     x = x - pi;
    //     flag = reverse_flag(flag);
    // }
    // if (x >= pihalf) {
    //     x = pi - x;
    // }
    // if (x <= piquat) {
    //     x = sin_main(x);
    // }
    // else {
    //     x = pihalf - x;
    //     x = cos_main(x);
    // }

    // if (flag == 1) {
    //     x = x * -1.0;
    // }

    // return x;
}

inline float FPU_soft::cos(float x) {
    if (x < 0.0)            return cos(-x);
    else if (x > piquat)    return sin(pihalf - x);
    else                    return cos_main(x);

    // int flag = 0;   // 0: pos, 1: neg

    // if (x < 0.0) {
    //     x = x * -1.0;
    // }

    // x = reduction_2pi(x);

    // if (x >= pi) {
    //     x = x - pi;
    //     flag = reverse_flag(flag);
    // }
    // if (x >= pihalf) {
    //     x = pi - x;
    //     flag = reverse_flag(flag);
    // }
    // if (x <= piquat) {
    //     x = cos_main(x);
    // }
    // else {
    //     x = pihalf - x;
    //     x = sin_main(x);
    // }

    // if (flag == 1) {
    //     x = x * -1.0;
    // }

    // return x;
}

inline U FPU_soft::sin(U x_u) {
    float x = x_u.f;

    U ret;
    ret.f = sin(x);

    return ret;
}

inline U FPU_soft::cos(U x_u) {
    float x = x_u.f;

    U ret;
    ret.f = cos(x);

    return ret;
}

inline float FPU_soft::atan(float x) {
    if (x < 0.0)            return -atan(-x);
    else if (x > 2.4375)    return pihalf - atan(1.0 / x);
    else if (x >= 0.4375)   return piquat + atan((x - 1.0) / (x + 1.0));
    else {
        // float x2 = x * x;
        // float x3 = x * x2;
        // float x4 = x2 * x2;
        // return x - 0.3333333 * x3 + 0.2 * x2 * x3 - 0.142857142 * x4 * x3 + 0.111111104 * x2 * x4 * x3 - 0.08976446 * x4 * x4 * x3;

        float x2 = x * x;
        
        return ((((((0.076923076923 * x2 + -0.090909090909) * x2 + 0.111111104) * x2 + -0.142857142) * x2 + 0.2) * x2 + -0.3333333) * x2 + 1.0) * x;
    }
}

inline U FPU_soft::atan(U x_u) {
    float x = x_u.f;

    U ret;
    ret.f = atan(x);
    
    return ret;
}

inline float FPU_soft::floor(float x) {
    int y = ftoi(x);
    float z = itof(y);

    if (z - 1.0 <= x && x < z) z = z - 1.0;

    return z;
}

inline U FPU_soft::floor(U x_u) {
    U ret;
    ret.f = floor(x_u.f);

    return ret;
}

inline int FPU_soft::int_of_float_rem(float x, int acc) {
    if (x >= -0.5) {
        if (x < 0.5) return acc;
        else return int_of_float_rem(x - 1.0, acc + 1);
    }
    else return int_of_float_rem(x + 1.0, acc - 1);
}

inline int FPU_soft::int_of_float_four(float x, int acc) {
    if (x >= 4.5)       return int_of_float_four(x - 4.0, acc + 4);
    else if (x < -4.5)  return int_of_float_four(x + 4.0, acc - 4);
    else                return int_of_float_rem(x, acc);
}

inline int FPU_soft::ftoi(float x) {
    return int_of_float_four(x, 0);
}

inline U FPU_soft::ftoi(U x_u) {
    U ret;
    ret.i = (unsigned int)ftoi(x_u.f);
    
    return ret;
}

inline float FPU_soft::itof(int x4) {
    if (x4 < 0) {
        x4 = -x4;
        return -itof(x4);
    }

    int x5 = 8388608;
    float f2 = 8388608.0;

    if (x5 > x4) {
        // itof_l
        int x6 = 1258291200;
        x4 = x4 + x6;

        U mem;
        mem.i = (unsigned int)x4;
        float f1 = mem.f;

        f1 = f1 - f2;
        return f1;
    }
    else {
        // itof_g: not called
        float f1 = 0;

        while(x5 <= x4) {
            x4 = x4 - x5;
            f1 = f1 + f2;
        }

        int x6 = 1258291200;
        x4 = x4 + x6;

        U mem;
        mem.i = (unsigned int)x4;
        float f3 = mem.f;

        f3 = f3 - f2;
        f1 = f1 + f3;
        return f1;
    }
}

inline U FPU_soft::itof(U x_u) {
    U ret;
    ret.f = itof((int)x_u.i);

    return ret;
}