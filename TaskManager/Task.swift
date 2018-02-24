//
//  Task.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/20/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class Task: Timer {
    var taskTime = TimeDeclaration()
    let name : String
    var isCompleted = false{
        didSet {
            completedDate = taskTime.formatter.date(from: taskTime.formatter.string(from: Date()))
        }
    }
    var description : String
    var completedDate : Date?
    var status : String {
        return self.isCompleted ? " (Completed)" : self.isLate ? " (Late)" : " (In Progress)"
    }
    var isLate : Bool {
        return self.dueDate < Date() && !self.isCompleted
    }
    
    init(name: String, description: String, dueDate: Date) {
        self.name = name
        self.description = description
        self.completedDate = nil
        super.init(dueDate: dueDate)
    }
    
}


