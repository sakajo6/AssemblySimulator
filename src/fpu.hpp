#pragma once

#include "fpu_init.hpp"

typedef unsigned long long int ull;
typedef long long int sll;

enum FPU_opcode {
    FPU_finv = 0,
    FPU_fadd = 1,
    FPU_fsub = 2,
    FPU_fmul = 3,
    FPU_fdiv = 4,
    FPU_fsqrt = 5,
    FPU_result = 6,
    FPU_feq = 7,
    FPU_fle = 8,
};

class FPU {
    private:
        ull bit(ull, ull, ull);
        void float_check(ull, FPU_opcode, int);

        U finv(U);

    public:
        FPU() {
            initfun::finv_init();
            initfun::fsqrt_init();
        }
        U fadd(U, U);
        U fsub(U, U);
        U fmul(U, U);
        U fdiv(U, U);
        U fsqrt(U);  
        bool feq(U, U);
        bool fle(U, U);
};


inline ull FPU::bit(ull d, ull m, ull l) {
    ull ret = d;
    ret <<= (63 - m);
    ret >>= (63 + l - m);

    return ret;
}

inline void FPU::float_check(ull x, FPU_opcode op, int reg) {
    ull e = bit(x, 30, 23);
    ull m = bit(x, 22, 0);

    if (e == 255) {
        if (m == 0) {
            std::cout << "\033[33m[warning]\033[m FPU: Infinity -> " << op << std::endl;
        }
        else {
            std::cout << "\033[33m[warning]\033[m FPU: NaN -> " << op << std::endl;
        }
    }
    else if (e == 0 && m != 0) {
        std::cout << "\033[33m[warning]\033[m FPU: Denormalized Number -> " << op << std::endl;
    }

    if (op == FPU_finv && reg == 0) {
        if (e == 0 && m == 0) {
            std::cout << "\033[33m[warning]\033[m FPU: zero division -> " << op << std::endl;
        }
    }
    else if (op == FPU_fdiv && reg == 1) {
        if (e == 0 && m == 0) {
            std::cout << "\033[33m[warning]\033[m FPU: zero division -> " << op << std::endl;
        }
    }
}

inline U FPU::fadd(U x1_u, U x2_u) {
    ull x1 = x1_u.i;
    ull x2 = x2_u.i;

    float_check(x1, FPU_fadd, 0);
    float_check(x2, FPU_fadd, 1);

    // #1
    ull s1, s2;
    ull e1, e2; // 7:0
    ull m1, m2; // 22:0
    s1 = bit(x1, 31, 31);
    s2 = bit(x2, 31, 31);
    e1 = bit(x1, 30, 23);
    e2 = bit(x2, 30, 23);
    m1 = bit(x1, 22, 0);
    m2 = bit(x2, 22, 0);

    // #2
    ull m1a, m2a; // 24:0
    m1a = (e1 == 0) ? ((ull)0b00 << 23) + bit(m1, 22, 0) : ((ull)0b01 << 23) + bit(m1, 22, 0);
    m1a = bit(m1a, 24, 0);
    m2a = (e2 == 0) ? ((ull)0b00 << 23) + bit(m2, 22, 0) : ((ull)0b01 << 23) + bit(m2, 22, 0);
    m2a = bit(m2a, 24, 0);

    // #3
    ull e1a, e2a; // 7:0
    e1a = (e1 == 0) ? 1 : bit(e1, 7, 0);
    e2a = (e2 == 0) ? 1 : bit(e2, 7, 0);

    // #4
    ull e2ai; // 7:0
    e2ai = bit(~e2a, 7, 0);

    // #5
    ull te; // 8:0
    te = bit(e1a, 7, 0) + bit(e2ai, 7, 0);
    te = bit(te, 8, 0);

    // #6
    ull ce;
    ull tde; // 7:0
    ce = (bit(te, 8, 8) == 1) ? 0 : 1;
    tde = (bit(te, 8, 8) == 1) ? bit(te, 7, 0) + 1 : bit(~te, 7, 0);
    tde = bit(tde, 7, 0);

    // #7
    ull de; // 4:0
    de = (bit(tde, 7, 5) != 0) ? 31 : bit(tde, 4, 0);
    de = bit(de, 4, 0);

    // #8
    ull sel;
    sel = (de == 0) ? ((m1a > m2a) ? 0 : 1) : ce;

    // #9
    ull ss;
    ull es, ei; // 7:0
    ull ms, mi; // 24:0
    ss = (sel == 0) ? s1 : s2;
    ms = (sel == 0) ? m1a : m2a;
    mi = (sel == 0) ? m2a : m1a;
    es = (sel == 0) ? e1a : e2a;
    ei = (sel == 0) ? e2a : e1a;

    // #10
    ull mie; // 55:0
    mie = bit(mi << 31, 55, 0);

    // #11
    ull mia; // 55:0
    mia = bit(mie >> de, 55, 0);

    // #12
    ull tstck;
    tstck = (bit(mia, 28, 0) != 0);

    // #13
    ull mye; // 26:0
    mye = (s1 == s2) ? (ms << 2) + bit(mia, 55, 29) : (ms << 2) - bit(mia, 55, 29);
    mye = bit(mye, 26, 0);

    // #14
    ull esi; // 7:0
    esi = bit(es + 1, 7, 0);

    // #15
    ull stck;
    ull eyd; // 7:0
    ull myd; // 26:0
    stck = (bit(mye, 26, 26) == 1) ? ((esi == 255) ? 0 : tstck || bit(mye, 0, 0)) : tstck;
    eyd = (bit(mye, 26, 26) == 1) ? ((esi == 255) ? 255 : esi) : es;
    myd = (bit(mye, 26, 26) == 1) ? ((esi == 255) ? ((ull)1 << 25) : (mye >> 1)) : mye;
    myd = bit(myd, 26, 0);

    // #16
    ull se; // 4:0
    se = 
        (bit(myd, 25, 25) == 1) ? 0 :
        (bit(myd, 24, 24) == 1) ? 1 :
        (bit(myd, 23, 23) == 1) ? 2 :
        (bit(myd, 22, 22) == 1) ? 3 :
        (bit(myd, 21, 21) == 1) ? 4 :
        (bit(myd, 20, 20) == 1) ? 5 :
        (bit(myd, 19, 19) == 1) ? 6 :
        (bit(myd, 18, 18) == 1) ? 7 :
        (bit(myd, 17, 17) == 1) ? 8 :
        (bit(myd, 16, 16) == 1) ? 9 :
        (bit(myd, 15, 15) == 1) ? 10 :
        (bit(myd, 14, 14) == 1) ? 11 :
        (bit(myd, 13, 13) == 1) ? 12 :
        (bit(myd, 12, 12) == 1) ? 13 :
        (bit(myd, 11, 11) == 1) ? 14 :
        (bit(myd, 10, 10) == 1) ? 15 :
        (bit(myd, 9, 9) == 1) ? 16 :
        (bit(myd, 8, 8) == 1) ? 17 :
        (bit(myd, 7, 7) == 1) ? 18 :
        (bit(myd, 6, 6) == 1) ? 19 :
        (bit(myd, 5, 5) == 1) ? 20 :
        (bit(myd, 4, 4) == 1) ? 21 :
        (bit(myd, 3, 3) == 1) ? 22 :
        (bit(myd, 2, 2) == 1) ? 23 :
        (bit(myd, 1, 1) == 1) ? 24 :
        (bit(myd, 0, 0) == 1) ? 25 : 26;
    se = bit(se, 4, 0);

    // #17
    sll eyf; // 8:0
    eyf = (sll)bit(eyd, 7, 0) - (sll)bit(se, 4, 0);
    eyf = bit(eyf, 8, 0);

    // #18
    ull eyr; // 7:0
    ull myf; // 26:0
    eyr = (bit(eyf, 8, 8) == 0 && bit(eyf, 7, 0) != 0) ? bit(eyf, 7, 0) : 0;
    eyr = bit(eyr, 7, 0);
    myf = (bit(eyf, 8, 8) == 0 && bit(eyf, 7, 0) != 0) ? (myd << se) : (myd << (bit(eyd, 4, 0) - 1));
    myf = bit(myf, 26, 0);

    // #19
    ull myr; // 24:0
    myr = ((bit(myf, 1, 1) == 1 && bit(myf, 0, 0) == 0 && stck == 0 && bit(myf, 2, 2) == 1) 
                || (bit(myf, 1, 1) == 1 && bit(myf, 0, 0) == 0 && s1 == s2 && stck == 1)
                || (bit(myf, 1, 1) == 1 && bit(myf, 0, 0) == 1)) ? bit(myf, 26, 2) + 1 : bit(myf, 26, 2);
    myr = bit(myr, 24, 0);

    // #20
    ull eyri; // 7:0
    eyri = eyr + 1;
    eyri = bit(eyri, 7, 0);

    // #21
    ull ey; // 7:0
    ull my; // 22:0
    ey = (bit(myr, 24, 24) == 1) ? eyri : ((bit(myr, 23, 0) == 0) ? 0 : eyr);
    ey = bit(ey, 7, 0);
    my = (bit(myr, 24, 24) == 1) ? 0 : ((bit(myr, 23, 0) == 0) ? 0 : bit(myr, 22, 0));
    my = bit(my, 22, 0);

    // #22
    ull sy;
    sy = (ey == 0 && my == 0) ? s1 && s2 : ss;

    // #23
    ull nzm1, nzm2;
    nzm1 = bit(m1, 22, 0) != 0;
    nzm2 = bit(m2, 22, 0) != 0;

    ull y =
        (e1 == 255 && e2 != 255) ?              (s1 << 31) + ((ull)255 << 23) + (nzm1 << 22) + bit(m1, 21, 0) :
        (e2 == 255 && e1 != 255) ?              (s2 << 31) + ((ull)255 << 23) + (nzm2 << 22) + bit(m2, 21, 0) :
        (e1 == 255 && e2 == 255 && nzm1) ?      (s1 << 31) + ((ull)255 << 23) + ((ull)1 << 22) + bit(m1, 21, 0) :
        (e1 == 255 && e2 == 255 && nzm2) ?      (s2 << 31) + ((ull)255 << 23) + ((ull)1 << 22) + bit(m2, 21, 0) :
        (e1 == 255 && e2 == 255 && s1 == s2) ?  (s1 << 31) + ((ull)255 << 23) :
        (e1 == 255 && e2 == 255) ?              ((ull)1 << 31) + ((ull)255 << 23) + ((ull)1 << 22) 
                                                        : (sy << 31) + (ey << 23) + my;
    y = bit(y, 31, 0);

    float_check(y, FPU_result, 0);

    U ret;
    ret.i = (unsigned int)y;

    return ret;
}

inline U FPU::fsub(U x1_u, U x2_u) {
    // yの符号反転. faddで計算
    ull x1 = x1_u.i;
    ull x2 = x2_u.i;

    float_check(x1, FPU_fsub, 0);
    float_check(x2, FPU_fsub, 1);

    ull minus_x2_31 = ~bit(x2, 31, 31);
    ull minus_x2_30_0 = bit(x2, 30, 0);

    ull minus_x2 = bit((minus_x2_31 << 31) + minus_x2_30_0, 31, 0);
    x2_u.i = (unsigned int)minus_x2;

    return fadd(x1_u, x2_u);
}

inline U FPU::fmul(U x1_u, U x2_u) {
    ull x1 = x1_u.i;
    ull x2 = x2_u.i;

    float_check(x1, FPU_fmul, 0);
    float_check(x2, FPU_fmul, 1);

    ull s1, s2;
    ull e1, e2; // 7:0
    ull mh1, mh2; // 12:0
    ull ml1, ml2; // 10:0

    s1 = bit(x1, 31, 31);
    s2 = bit(x2, 31, 31);
    e1 = bit(x1, 30, 23);
    e2 = bit(x2, 30, 23);
    mh1 = ((ull)1 << 12) + bit(x1, 22, 11);
    mh2 = ((ull)1 << 12) + bit(x2, 22, 11);
    ml1 = bit(x1, 10, 0);
    ml2 = bit(x2, 10, 0);

    ull hh; // 26:0
    ull hl; // 24:0
    ull lh; // 24:0
    hh = bit(mh1 * mh2, 26, 0);
    hl = bit(mh1 * ml2, 24, 0);
    lh = bit(ml1 * mh2, 24, 0);

    ull sy;
    sy = s1 ^ s2;

    ull ey_sub; // 8:0
    ey_sub = bit(e1 + e2 + 129, 8, 0);

    ull my_sub; // 27:0
    ull hl_2, lh_2; // 13:0
    hl_2 = bit(hl >> 11, 13, 0);
    lh_2 = bit(lh >> 11, 13, 0);
    my_sub = bit(hh + hl_2 + lh_2, 27, 0);   // 精度の都合上 +2 が必要かも

    ull ey_sub_2; // 8:0
    ey_sub_2 = bit(ey_sub + 1, 8, 0);

    ull ey; // 7:0
    ey = bit(~ey_sub, 8, 8)   ? 0 : 
        bit(bit(my_sub, 25, 25), 0, 0)   ? bit(ey_sub_2, 7, 0) : bit(ey_sub, 7, 0);
    ey = bit(ey, 7, 0);

    ull my; // 22:0
    my = bit(my_sub, 27, 27) ? bit(my_sub, 26, 4) :
        bit(my_sub, 26, 26) ? bit(my_sub, 25, 3) :
        bit(my_sub, 25, 25) ? bit(my_sub, 24, 2) : bit(my_sub, 23, 1);

    ull y;  // 31:0
    y = (e1 == 0 || e2 == 0) ? 0 : (sy << 31) + (ey << 23) + my;
    y = bit(y, 31, 0);

    float_check(y, FPU_result, 0);

    U ret;
    ret.i = (unsigned int)y;

    return ret;
}

inline U FPU::finv(U x_u) {
    ull x = x_u.i;

    float_check(x, FPU_finv, 0);

    ull addr; // 9:0
    addr = bit(x, 22, 13);

    ull a; // 31:0
    ull b; // 31:0
    a = (ull)finv_A[addr].i;
    b = (ull)finv_B[addr].i;

    ull x_2; // 31:0
    x_2 = (((ull)0b01111111) << 23) + bit(x, 22, 0);
    x_2 = bit(x_2, 31, 0);
    

    U a_u, b_u, x_2_u;
    a_u.i = a;
    b_u.i = b;
    x_2_u.i = x_2; 

    U ax;
    ax = fmul(a_u, x_2_u);

    U ret;
    ret = fsub(b_u, ax);

    return ret;
}

inline U FPU::fdiv(U x1_u, U x2_u) {
    ull x1 = (ull)x1_u.i;
    ull x2 = (ull)x2_u.i;

    float_check(x1, FPU_fdiv, 0);
    float_check(x2, FPU_fdiv, 1);

    ull y_s;
    y_s = bit(x1, 31, 31) ^ bit(x2, 31, 31);

    ull x1_f; // 31:0
    x1_f = ((ull)0b01111111 << 23) + bit(x1, 22, 0);

    ull y_e_1; // 8:0
    y_e_1 = bit(x1, 30, 23) - bit(x2, 30, 23);

    ull j; // 8:0
    j = y_e_1 + 126;

    ull y_e_4; // 8:0
    y_e_4 = (bit(j, 8, 8) << 8) + bit(y_e_1, 7, 0);

    U x1_f_u;
    x1_f_u.i = (unsigned int)x1_f;

    U x3_u = finv(x2_u);
    ull x4 = fmul(x1_f_u, x3_u).i;

    ull y;
    y = (bit(x1, 30, 0) == 0) ? 0 :
        (bit(y_e_4, 8, 8) ? 0 : (y_s << 31) + (bit((y_e_4 + bit(x4, 30, 23)), 7, 0) << 23) + bit(x4, 22, 0));

    float_check(y, FPU_result, 0);

    U ret;
    ret.i = (unsigned int)y;
    return ret;
}

inline U FPU::fsqrt(U x_u) {
    ull x = x_u.i;

    float_check(x, FPU_fsqrt, 0);

    ull addr; // 9:0
    addr = bit(x, 23, 14);

    ull a; // 31:0
    ull b; // 31:0
    a = (ull)fsqrt_A[addr].i;
    b = (ull)fsqrt_B[addr].i;

    ull x_2; // 31:0
    x_2 = bit(x, 23, 23) ? (0b001111111 << 23) + bit(x, 22, 0) : (0b010000000 << 23) + bit(x, 22, 0);

    U x_2_u, a_u, b_u;
    x_2_u.i = x_2;
    a_u.i = a;
    b_u.i = b;

    U ax_u = fmul(x_2_u, a_u);
    U y_f_u = fadd(b_u, ax_u);

    ull ax = ax_u.i;
    ull y_f = y_f_u.i;
    
    ull y_e; // 7:0
    y_e = ((bit(x, 30, 23) - 1) >> 1) + 64;
    y_e = bit(y_e, 7, 0);

    ull x_e; // 7:0
    x_e = bit(x, 30, 23);

    ull y; // 31:0
    y = x_e ?
        (bit(y_f, 24, 23) == 0b11 ? (y_e << 23) + bit(y_f, 22, 0) :
        (bit(y_f, 24, 23) == 0b10 ? ((y_e - 1) << 23) + bit(y_f, 22, 0) : ((y_e + 1) << 23) + bit(y_f, 22, 0))) : 0;

    float_check(y, FPU_result, 0);

    U ret; 
    ret.i = (unsigned int)y;
    return ret;
}

inline bool FPU::feq(U x_u, U y_u) {
    ull x = (ull)x_u.i;
    ull y = (ull)y_u.i;

    float_check(x, FPU_feq, 0);
    float_check(y, FPU_feq, 1);

    ull x_30_0 = bit(x, 30, 0);
    ull y_30_0 = bit(y, 30, 0);

    return (x == y || ((x_30_0 == y_30_0) && (x_30_0 == 0))) ? true : false;
}

inline bool FPU::fle(U x_u, U y_u) {
    ull x = (ull)x_u.i;
    ull y = (ull)y_u.i;

    float_check(x, FPU_feq, 0);
    float_check(y, FPU_feq, 1);

    ull x_31 = bit(x, 31, 31);
    ull y_31 = bit(y, 31, 31);
    ull x_30_23 = bit(x, 30, 23);
    ull y_30_23 = bit(y, 30, 23);
    ull x_22_0 = bit(x, 22, 0);
    ull y_22_0 = bit(y, 22, 0);

    return (x_31 > y_31) ? true :
        (((x_31 == y_31) && (x_31 == 0)) ? ((x_30_23 < y_30_23) ? true : ((x_30_23 == y_30_23) && (x_22_0 <= y_22_0))) :
        (((x_31 == y_31) && (x_31 == 1)) ? ((x_30_23 > y_30_23) ? true : ((x_30_23 == y_30_23) && (x_22_0 >= y_22_0))) : false));
}