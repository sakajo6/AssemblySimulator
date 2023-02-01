#pragma once

#include <iostream>
#include <bitset>

class FPU_soft {
    private:
        float pi, pi2, pihalf, piquat;

        float sin_main(float);
        float sin(float);
        float cos_main(float);
        float cos(float);
        float atan(float);

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

inline float FPU_soft::sin_main(float x) {
    // float x2 = x * x;
    // float x3 = x * x2;

    // return  x - 0.16666668 * x3 + 0.008332824 * x2 * x3 - 0.00019587841 * x2 * x2 * x3;

    float x2 = x * x;

    return (((-0.00019587841 * x2 + 0.008332824) * x2 + -0.16666668) * x2 + 1)*x;
}

inline float FPU_soft::cos_main(float x) {
    // float x2 = x * x;
    // float x4 = x2 * x2;

    // return 1.0 - 0.5 * x2 + 0.04166368 * x4 - 0.0013695068 * x2 * x4;

    float x2 = x * x;

    return ((-0.0013695068 * x2 + 0.04166368) * x2 + -0.5) * x2 + 1.0;
}

inline float FPU_soft::sin(float x) {
    if (x < 0.0)            return -sin(-x);
    else if (x >= pi2)      return sin(x - pi2);
    else if (x >= pi)       return -sin(x - pi);
    else if (x > pihalf)    return sin(pi - x);
    else if (x >= piquat)   return cos_main(pihalf - x);
    else                    return sin_main(x);
}

inline float FPU_soft::cos(float x) {
    if (x < 0.0)            return cos(-x);
    else if (x > piquat)    return sin(pihalf - x);
    else                    return cos_main(x);
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
        
        return (((((-0.08976446 * x2 + 0.111111104) * x2 + -0.142857142) * x2 + 0.2) * x2 + -0.3333333) * x2 + 1.0) * x;
    }
}

inline U FPU_soft::atan(U x_u) {
    float x = x_u.f;

    U ret;
    ret.f = atan(x);
    
    return ret;
}

inline U FPU_soft::floor(U x_u) {
    
    return x_u;
}

inline U FPU_soft::ftoi(U x_u) {
    
    return x_u;
}

inline U FPU_soft::itof(U x_u) {

    return x_u;
}