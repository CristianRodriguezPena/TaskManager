//
//  Task.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/22/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class Task {
    let name :String
    var description :String
    let `e :Date
    let dueDate :Date
    var isCompleted = false {
        didSet {
            completedDate = Date()
        }
    }
    var completedDate :Date? = nil
    var status : String {
        return self.isCompleted ? "Completed" : self.isLate ? "Late" : "In Progress"
    }
    var isLate : Bool {
        return self.dueDate < Date() && !self.isCompleted
    }
    
    init(name: String, description: String, dueDate: Date) {
        self.name = name
        self.description = description
        self.startDate = Date()
        self.dueDate = dueDate
    }
}


