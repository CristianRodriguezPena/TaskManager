//
//  TaskList.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/20/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class TaskList {
    var uncompletedList : [Task] {
        return allList.filter {!$0.isCompleted}
    }
    var completedList : [Task] {
        return allList.filter {$0.isCompleted}
    }
    var allList = [Task]()
}

class TaskFilter {
    private var out = [Task]()
    private let time = TimeDeclaration()
    var filters : [Task]
    var taskExtention : [String]

    func filter(filter: Int) -> [Task] {
        func sortByCompletionDate() -> [Task] {
            let uselessOnes = filters.filter {$0.completedDate == "not completed"}
            let usefulOnes = filters.filter {!($0.completedDate == "not completed")}.sorted {time.formatter.date(from: $0.completedDate)! < time.formatter.date(from: $1.completedDate)!}
            taskExtention = usefulOnes.map {"Completion date: " + $0.completedDate} + uselessOnes.map {$0.completedDate}
            return usefulOnes + uselessOnes
        }
        func sortByStartDate() -> [Task] {
            out = filters.sorted {$0.initDate < $1.initDate}
            taskExtention = out.map {"Start date: " + time.formatter.string(from: $0.initDate)}
            return out
        }
        func sortByDueDate() -> [Task] {
            out = filters.sorted {$0.dueDate < $1.dueDate}
            taskExtention = out.map {"Due date: " + time.formatter.string(from: $0.dueDate)}
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


