//
//  Utilities.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/21/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

//Find functions that you think would be beneficial to you no matter what project you're working on and put them here. I have a utlilities file that I move from project to project that I periodically work on and update. I would suggest that you also start doing this since your skill level is good enough to start focusing on that. 

func lineSpaces(lines: Int) {
    for _ in 1...lines {
        print("")
    }
}


//Nifty! Would recommend focus on understanding how this works and getting a solid understanding of generics.
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







