//  StackPuter - StackEval.swift
//  Created by Travis Luckenbaugh on 5/26/23.

import Foundation

enum StackError: Error {
    case underflow
}

class Stack {
    var stack = [Double]()
    
    func pop() throws -> Double {
        if let top = stack.popLast() {
            return top
        } else {
            throw StackError.underflow
        }
    }
    
    func push(_ s: Double) {
        stack.append(s)
    }
}

let constants: [String: Double] = [
    "PI" : 3.14159265358979323846,        // π
    "E" : 2.71828182845904523536,         // Base of natural logarithms
    "GAMMA" : 0.57721566490153286060,     // Euler-Mascheroni constant
    "DEG" : 57.29577951308232087680,      // Degrees per radian
    "PHI" : 1.61803398874989484820,       // Golden ratio
]

let monadic: [String: (Double) -> Double] = [
    "abs" : { abs($0) },
    "sqrt" : { sqrt($0) },
    "sin" : { sin($0) },
    "cos" : { cos($0) },
    "tan" : { tan($0) },
    "asin" : { asin($0) },
    "acos" : { acos($0) },
    "atan" : { atan($0) },
    "exp" : { exp($0) },
    "log" : { log($0) },
    "log10" : { log10($0) },
    "int" : { floor($0) },
]

let dyadic: [String: (Double, Double) -> Double]  = [
    "+": { $0 + $1 },
    "-": { $0 - $1 },
    "*": { $0 * $1 },
    "/": { $0 / $1 },
    
]

func eval(_ forms: String) -> [Double] {
    let stack = Stack()
    let scanner = Scanner(string: forms)
    
    do {
        while !scanner.isAtEnd, let token = scanner.scanUpToCharacters(from: .whitespaces) {
            if (token.range(of: #"^-?\d+(.\d+)?$"#, options: .regularExpression) != nil) {
                stack.push(Double(token)!)
            } else if let constant = constants[token] {
                stack.push(constant)
            } else if let monad = monadic[token] {
                let val = try stack.pop()
                stack.push(monad(val))
            } else if let dyad = dyadic[token] {
                let rhs = try stack.pop()
                let lhs = try stack.pop()
                stack.push(dyad(lhs, rhs))
            }
        }
    } catch {
        // TODO: Error handler
    }
    return stack.stack
}
