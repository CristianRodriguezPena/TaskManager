//
//  Utilities.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/22/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

//Would change the name of the function to what it actually does: printLineSpaces maybe?
func lineSpaces(lines: Int) {
    for _ in 1...lines {
        print("")
    }
}

//This is a good function. Good use of generics and recursion! I would change the name of the function to something like getUserInput, since we generally want functions to start with a verb referring to what they do
func userInput<T>(question: String?) -> T {
    let time = TimeDeclaration()
    if !(question == nil) {
        print(question!)
    }
    
    let realResponse = readLine()! //Would recommend changing the name of this variable- calling it realResponse doesn't say much about what it actually is. A better name in my opinion would be userResponse, as it is something the user has entered
    if T.self == Int.self, let input = Int(realResponse)  {
            return input as! T
    }
    
    if T.self == Date.self, let input = time.formatter.date(from: realResponse) {
            return input as! T
    }
    
    if T.self == String.self {
        return realResponse as! T
    }
    
    lineSpaces(lines: 1)
    print("That is not a valid input, please enter an \(T.self)")
    return userInput(question: question)
}







