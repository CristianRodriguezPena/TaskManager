//
//  Utilities.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/22/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

func lineSpaces(lines: Int) {
    for _ in 1...lines {
        print("")
    }
}

func userInput<T>(question: String?) -> T {
    if !(question == nil) {
        print(question!)
    }
    
    let realResponse = readLine()!
    if T.self == Int.self {
        if let input = Int(realResponse)  {
            return input as! T
        }
    }
    
    if T.self == Date.self {
        if let input = formatter.date(from: realResponse) {
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

func bubbleSort(list: inout[Int], startAt: Int) {
    if startAt == list.count - 1 {
        return
    }
    if list[startAt] > list[startAt + 1] {
        list.swapAt(startAt, startAt + 1)
        bubbleSort(list: &list, startAt: startAt == 0 ? 0 : startAt - 1 )
    } else {
        bubbleSort(list: &list, startAt: startAt + 1)
    }
}

public var formatter : DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/d/yy h:mm a"
    formatter.timeZone = TimeZone(abbreviation: "EST")
    return formatter
}


