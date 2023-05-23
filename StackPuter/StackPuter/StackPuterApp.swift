//
//  StackPuterApp.swift
//  StackPuter
//
//  Created by Travis Luckenbaugh on 5/9/23.
//

import SwiftUI

class Stack {
    var stack = [String]()
    
    func pop() -> String {
        return stack.popLast()!
    }
    
    func push(_ s: String) {
        stack.append(s)
    }
}

let monadic = ["abs", "sqrt"]
func apply(_ operation: String, _ num: Int) -> Int {
    switch operation {
    case "abs":
        return abs(num)
    case "sqrt":
        return Int(sqrt(Double(num)))
    default:
        return 0
    }
}
let dyadic = ["+", "-", "*", "/"]
func apply(_ operation: String, _ num1: Int, _ num2: Int) -> Int {
    switch operation {
    case "+":
        return num1 + num2
    case "-":
        return num1 - num2
    case "*":
        return num1 * num2
    case "/":
        return num1 / num2
    default:
        return 0
    }
}

func eval(_ forms: String) -> [String] {
    let stack = Stack()
    let scanner = Scanner(string: forms)
    
    while !scanner.isAtEnd, let token = scanner.scanUpToCharacters(from: .whitespaces) {
        if (token.range(of: #"^-?\d+$"#, options: .regularExpression) != nil) {
            stack.push(token)
        } else if monadic.contains(token) {
            let val = Int(stack.pop())!
            stack.push(String(apply(token, val)))
        } else if dyadic.contains(token) {
            let lhs = Int(stack.pop())!
            let rhs = Int(stack.pop())!
            stack.push(String(apply(token, lhs, rhs)))
        }
    }
    return stack.stack
}

@main struct StackPuterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
