//
//  Task.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/22/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class Task: Timer { //From the object oriented side of things, it doesn't make much sense to have a Task class that inherits from the Timer class since that relationship doesn't correspond to how things work in the real world. Looking at the timer class, the functionality from it could be integrated into this class and would probably be easier to understand.
    private var taskTime = TimeDeclaration()
    let name : String
    var isCompleted = false {
        didSet {
            completedDate = taskTime.formatter.string(from: Date())
        }
    }
    var description : String
    var completedDate = "not completed"
    var status : String {
        return self.isCompleted ? "Completed" : self.isLate ? "Late" : "In Progress"
    }
    var isLate : Bool {
        return self.dueDate < Date() && !self.isCompleted
    }
    
    init(name: String, description: String, dueDate: Date) {
        self.name = name
        self.description = description
        super.init(dueDate: dueDate)
    }
    
}


