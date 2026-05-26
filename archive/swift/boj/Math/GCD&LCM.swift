//
//  GCD&LCM.swift
//  AlgorithmStudy
//
//  Created by zaehorang on 7/28/25.
//  최대 공약수 & 최소 공배수 구하기

func gcd(a: Int, b: Int) -> Int {
    if b == 0 { return a }
    return gcd(a: b, b: a % b)
}

func lcm(a: Int, b: Int) -> Int {
    return a / gcd(a: a, b: b) * b
}
