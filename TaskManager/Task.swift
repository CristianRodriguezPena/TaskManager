//
//  Task.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/22/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class Task: Timer {
    
    /*
 
        - Group your properties by type. Keep constants, variables, and computed properties separate in groups.
        - Never include a space after the color in a type declaration. i.e. let name: String instead of let name : String
        - completedDate should be of type Date?
        -
     
     */
    
    
    
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


