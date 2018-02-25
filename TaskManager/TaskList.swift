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
        return list.filter {!$0.isCompleted}
    }
    var completedList : [Task] {
        return list.filter {$0.isCompleted}
    }
    var allList : [Task] {
        return list
    }
    var list = [Task]()
}

class TaskFilter {
    var filters : [Task]
    var sortByStartDate : [Task] {
        return sortByName.sorted {$0.initDate < $1.initDate}
    }
    var sortByDueDate : [Task] {
        return sortByName.sorted {$0.dueDate < $1.dueDate}
    }
    var sortByStatus : [Task] {
        return sortByName.sorted {$0.status < $1.status}
    }
    var sortByName : [Task] {
        return filters
    }
    init(filter: [Task]) {
        self.filters = filter
    }
}


