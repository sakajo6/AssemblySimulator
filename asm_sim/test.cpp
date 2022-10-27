#include <stdio.h>
#include <iostream>


#include <bitset>

int main() {
    std::bitset<8> test(std::string("1010") + std::string("1010"));
    std::cout<<test.to_string()<<std::endl;

    std::cout << -10 % 32 << std::endl;
}