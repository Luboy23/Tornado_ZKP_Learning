pragma circom 2.0.0;

//  f(x,y) = x ^ 2 * y + x * y ^ 2 + 17;

//  定义信号
//  1. 所有的输入都是信号
//  2. 两个信号每次相乘都需要定义一个新信号
//  3. 只有通过两个信号才能生成一个新信号
//  4. 所有的输出也都是信号

template F() {
    signal input x;
    signal input y;
    signal output o;

    signal m1 <== x * x;
    signal m2 <== m1 * y;

    signal m3 <== y * y;
    signal m4 <== m3 * x;

    o <== m2 + m4 + 17;
}

component main = F();