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


func eval(_ forms: String) -> [String] {
    let stack = Stack()
    let scanner = Scanner(string: forms)
    
    while !scanner.isAtEnd, let token = scanner.scanUpToCharacters(from: .whitespaces) {
        if (token.range(of: #"^\d+$"#, options: .regularExpression) != nil) {
            stack.push(token)
        } else if token == "+" {
            let lhs = Int(stack.pop())!
            let rhs = Int(stack.pop())!
            stack.push(String(lhs + rhs))
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
