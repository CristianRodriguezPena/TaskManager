//
//  Task.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/20/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class Task: Timer {
    let name : String
    var isCompleted = false
    var description : String
    var status : String {
        return self.isCompleted ? " (Completed)" : self.isLate ? " (Late)" : " (In Progress)"
    }
    var isLate : Bool {
        return self.dueDate < Date() && !self.isCompleted
    }
    
    init(name: String, description: String, dueDate: Date) {
        self.name = name
        self.description = description
        super.init(dueDate: dueDate)
        self.description = description
    }
    
}


