//
//  TaskTimer.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/20/18.
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

class TimeDeclaration {
    let formatter = DateFormatter()
    init() {
        formatter.dateFormat = "MM/d/yy H:mm a"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
    }
}
