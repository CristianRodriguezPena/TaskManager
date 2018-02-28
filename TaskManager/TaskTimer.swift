//
//  TaskTimer.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/22/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation
class Timer {
    let initDate : Date
    let dueDate : Date
    
    init(dueDate: Date) {
        self.initDate = Date()
        self.dueDate = dueDate
    }
}

//The name of this class is confusing to me. I can see that it serves as a class that initializes a date formatter with a given format and timezone, but as a class it's hard to know what a "TimeDeclaration" is as an object. Might make more sense to call it "Formatter" or something to that effect.
class TimeDeclaration {
    let formatter = DateFormatter()
    init() {
        formatter.dateFormat = "MM/d/yy H:mm a"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
    }
}
