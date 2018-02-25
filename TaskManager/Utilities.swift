//
//  Utilities.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/21/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

func lineSpaces(lines: Int) {
    for _ in 1...lines {
        print("")
    }
}

func userInput<T>(question: String?) -> T {
    let time = TimeDeclaration()
    if let questionCheck = question {
        print(questionCheck)
    }
    
    let realResponse = readLine()!
    if T.self == Int.self {
        if let input = Int(realResponse) {
            return input as! T
        }
    }
    
    if T.self == Date.self {
        if let input = time.formatter.date(from: realResponse) {
            return input as! T
        }
    }
    
    if T.self == String.self {
        return realResponse as! T
    }
    lineSpaces(lines: 1)
    print("That is not a valid input, please enter an \(T.self)")
    return userInput(question: question)
}







