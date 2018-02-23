//
//  Tasks.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/20/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class taskList {
    var uncompletedList : [Task] {
        return allList.filter {!$0.isCompleted}
    }
    var completedList : [Task] {
        return allList.filter {$0.isCompleted}
    }
    var allList = [Task]()
}
