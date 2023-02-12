#include <iostream>
#include <iomanip>
#include <cmath>
#include <bitset>

union U {
    unsigned int i;
    float f;
};

U fsqrt_A[1024];
U fsqrt_B[1024];

long double addrTold(int addr) {
    long double ret = 1.0;
    long double x = 1.0;
    for(int i = 8; i >= 0; i--) {
        x /= 2.0;
        if ((addr >> i) & 1) {
            ret += x;
        }
    }

    return ret;
}


int main() {
    std::cout << std::setprecision(15) << std::endl;

    // addr == 0****|***** -> x' = 1*.***|*****
    // addr == 1****|***** -> x' = 1.****|*****

    long double prev = 0.0;
    for (int addr = 0; addr < 1024; addr++) {
        // addr -> long double
        long double x = addrTold(addr);

        if (((addr >> 9) & 1) == 0) {
            x *= 2.0;
        } else {
            x *= 1.0;
        }

        long double e =  (1.0/pow(2.0, 16) - 1.0/pow(2.0, 18))/1024.0;

        long double c = (std::sqrt(x + e) - std::sqrt(x)) / e;
        long double x_0 = (c*(x + e/2.0) + std::sqrt(x) - c*x + std::sqrt(x + e/2.0))/2.0;    

        long double a = 1 / (2.0 * x_0);
        long double b = x_0 / 2.0;

        U a_u, b_u;
        a_u.f = (float)a;
        b_u.f = (float)b;

        fsqrt_A[addr] = a_u;
        fsqrt_B[addr] = b_u;
    }

    // // for .cpp
    // for (int i = 0; i < 1024; i++) {
    //     std::cout << "\t\tfsqrt_A[" << i << "].i = 0b" << std::bitset<32>(fsqrt_A[i].i).to_string() << ";" << std::endl;
    // }

    // for (int i = 0; i < 1024; i++) {
    //     std::cout << "\t\tfsqrt_B[" << i << "].i = 0b" << std::bitset<32>(fsqrt_B[i].i).to_string() << ";" << std::endl;
    // }

    // for .sv
    for (int i = 0; i < 1024; i++) {
        std::cout << "      11'd" << i << ": A = 32'b" << std::bitset<32>(fsqrt_A[i].i).to_string() << ";\t//" << fsqrt_A[i].f << std::endl;
    }

    std::cout << std::endl;

    for (int i = 0; i < 1024; i++) {
        std::cout << "      11'd" << i << ": B = 32'b" << std::bitset<32>(fsqrt_B[i].i).to_string() << ";\t//" << fsqrt_B[i].f << std::endl;
    }

    return 0;
}