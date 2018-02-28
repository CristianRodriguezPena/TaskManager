//
//  TaskList.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/22/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class TaskList {
    var allList = [Task]()
    
    var uncompletedList : [Task] {
        return allList.filter {!$0.isCompleted}
    }
    var completedList : [Task] {
        return allList.filter {$0.isCompleted}
    }
}

class TaskFilter: TimeDeclaration {
    private var out = [Task]() //Rename this for clarity. Maybe output instead of out?
    var filters : [Task]
    var taskExtention : [String]

    func filter(filter: Int) -> [Task] {
        
        //Be careful with declaring functions inside of other functions. This works here because you never need to access the inner functions outside of the filter function, but you would be unable to if you did ever need to.
        
        func sortByCompletionDate() -> [Task] {
            let uselessOnes = filters.filter {$0.completedDate == "not completed"}
            let usefulOnes = filters.filter {!($0.completedDate == "not completed")}.sorted {formatter.date(from: $0.completedDate)! < formatter.date(from: $1.completedDate)!}
            taskExtention = usefulOnes.map {"Completion date: " + $0.completedDate} + uselessOnes.map {$0.completedDate}
            
            return usefulOnes + uselessOnes
        }
        
        func sortByStartDate() -> [Task] {
            out = filters.sorted {$0.initDate < $1.initDate}
            taskExtention = out.map {"Start date: " + formatter.string(from: $0.initDate)}
            
            return out
        }
        
        func sortByDueDate() -> [Task] {
            out = filters.sorted {$0.dueDate < $1.dueDate}
            taskExtention = out.map {"Due date: " + formatter.string(from: $0.dueDate)}
            
            return out
        }
        
        func sortByStatus() -> [Task] {
            out = filters.sorted {$0.status < $1.status}
            taskExtention = out.map {"Status: " + $0.status}
            
            return out
        }
        
        func sortByName() -> [Task] {
            taskExtention = filters.map {$0.status}
            return filters.sorted {$0.name < $1.name}
            
        }
        
        switch filter {
        case 2:
            return sortByStartDate()
        case 3:
            return sortByDueDate()
        case 4:
            return sortByStatus()
        case 5:
            return sortByCompletionDate()
        default:
            return sortByName()
        }
    }
    
    init(filter: [Task]) {
        filters = filter
        taskExtention = Array(repeatElement(" ", count: filter.count))
    }
}


