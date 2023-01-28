#pragma once

#include <iostream>
#include <bitset>

union U {
    unsigned int i;
    float f;
};

typedef unsigned long long int ull;
typedef long long int sll;

class FPU {
    private:
        U finv(U);
    public:
        ull bit(ull, ull, ull);
        U fadd(U, U);
        U fsub(U, U);
        U fmul(U, U);
        U fdiv(U, U);
        U fsqrt(U);
};

inline ull FPU::bit(ull d, ull m, ull l) {
    ull ret = d;
    ret /= ((ull)1 << l);
    ret %= ((ull)1 << (m + 1));

    return ret;
}

inline U FPU::finv(U x) {
    // fmul, fsubで計算

    U ret;
    return ret;
}

inline U FPU::fadd(U x1_u, U x2_u) {
    ull x1 = x1_u.i;
    ull x2 = x2_u.i;

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

    U ret;
    ret.i = (unsigned int)y;

    return ret;
}

inline U FPU::fsub(U x1_u, U x2_u) {
    // yの符号反転. faddで計算
    ull x2 = x2_u;

    ull minus_x2_31 = ~bit(x2, 31, 31);
    ull minus_x2_30_0 = bit(x2, 30, 0);

    ull minus_x2 = bit((minus_x2_31 << 31) + minus_x2_30_0, 31, 0);
    x2_u.i = (unsigned int)minus_x2;

    return fadd(x1, x2);
}

inline U FPU::fmul(U x, U y) {
    // 頑張ってエミュレート

    U ret;
    return ret;
}

inline U FPU::fdiv(U x, U y) {
    // finv を用いて計算

    U ret;
    return ret;
}

inline U FPU::fsqrt(U x) {
    U ret; 
    return ret;
}
