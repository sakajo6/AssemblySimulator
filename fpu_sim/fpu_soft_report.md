# 浮動小数点演算 ソフトウェア実装

## sin
- x < 10.0ならばsin(x)は要件満たす
- Horner方を用いるとより高速
- 同じ計算量で9次まで

## cos
- 6次だと誤差が厳しい
- 10次なら、x < 10.0で要件満たす
- Horner法用いるとより高速

## atan
- 現状11次で実装しているが、13次までの近似で要件を完全に満たせる。
- Horner法用いるとより高速

## floor

## ftoi(int of float)

## itof(float of int)