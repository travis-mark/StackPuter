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
    "abs" : abs,
    "sqrt" : sqrt,
    "sin" : sin,
    "cos" : cos,
    "tan" : tan,
    "asin" : asin,
    "acos" : acos,
    "atan" : atan,
    "exp" : exp,
    "log" : log,
    "log10" : log10,
    "int" : floor,
    "~" : { Double(~(Int($0))) },
    "signum" : { $0 == 0 ? 0 : $0 > 0 ? 1 : -1 }
]

let dyadic: [String: (Double, Double) -> Double]  = [
    "+" : { $0 + $1 },
    "-" : { $0 - $1 },
    "*" : { $0 * $1 },
    "/" : { $0 / $1 },
    "%" : { $0.truncatingRemainder(dividingBy: $1) },
    "&" : { Double(Int($0) & Int($1)) },
    "|" : { Double(Int($0) | Int($1)) },
    "^" : { Double(Int($0) ^ Int($1)) },
    "<<" : { Double(Int($0) << Int($1)) },
    ">>" : { Double(Int($0) >> Int($1)) },
    "isMultiple" : { Int($0).isMultiple(of: Int($1)) ? 1 : 0  }
]

func eval(_ forms: String) -> String {
    let stack = Stack()
    let scanner = Scanner(string: forms)
    while !scanner.isAtEnd, let token = scanner.scanUpToCharacters(from: .whitespaces) {
        do {
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
        } catch {
            if error as! StackError == StackError.underflow {
                return "Attempted to pop from empty stack while resolving symbol: \(token)"
            } else {
                return "Error: \(error.localizedDescription)"
            }
            
        }
    }
    return stack.stack.map({ $0 == floor($0) ? String(Int($0)) : String($0) }).joined(separator: " ")
}
