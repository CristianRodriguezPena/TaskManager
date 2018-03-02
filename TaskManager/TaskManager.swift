//
//  TaskManager.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/22/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class TaskManager  {
    var allTasks = [Task]()
    var completedList :[Task] {
        return allTasks.filter {$0.isCompleted}
    }
    var incompletedList :[Task] {
        return allTasks.filter {!$0.isCompleted}
    }
    
    private var filterExtension = 1
    private var taskExtension = [String]()
    
    func sortTasks() {
        func sortByCompletionDate() {
        let uselessOnes = allTasks.filter {$0.completedDate == nil}
        let usefulOnes = allTasks.filter {!($0.completedDate == nil)}.sorted {$0.completedDate! < $1.completedDate!}
        taskExtension = usefulOnes.map {"Completion date: " + formatter.string(from: $0.completedDate!)} + uselessOnes.map {_ in "Not completed"}
        
        allTasks = usefulOnes + uselessOnes
        }
        
        func sortByStartDate() {
            allTasks = allTasks.sorted {$0.startDate < $1.startDate}
            taskExtension = allTasks.map {"Start date: " + formatter.string(for: $0.startDate)!}
        }
        func sortByDueDate() {
            allTasks = allTasks.sorted {$0.dueDate < $1.dueDate}
            taskExtension = allTasks.map {"Due date: " + formatter.string(for: $0.dueDate)!}
        }
        func sortByStatus() {
            allTasks = allTasks.sorted {$0.status < $1.status}
            taskExtension = allTasks.map {"Status: " + $0.status}
        }
        func sortByName() {
            allTasks = allTasks.sorted {$0.name < $1.name}
            taskExtension = allTasks.map {$0.status}
            
        }
        
        switch filterExtension {
        case 2:
            sortByStartDate()
        case 3:
            sortByDueDate()
        case 4:
            sortByStatus()
        case 5:
            sortByCompletionDate()
        default:
            sortByName()
        }
        
    }
    
    func launch() {
        lineSpaces(lines: 1)
        print("\\Welcome to Task Manager/")
        lineSpaces(lines: 1)
        mainMenu()
    }
    
    func mainMenu () {
        print("Please enter the number of what you would like to do -")
        lineSpaces(lines: 1)
        let intResponse: Int = userInput(question: """
            1) View list of all tasks
            2) View list of all uncompleted tasks
            3) View list of all completed tasks
            4) Begin a new task
            5) Mark a task as completed
            6) Delete a task
            7) Exit Program
            """)
        
        if !((1...7).contains(intResponse)) {
            mainMenu()
        }
        
            switch intResponse {
            case 1:
                showTasks(question: "Press 'Enter' to go back to main menu", completed: nil)
            case 2:
                showTasks(question: "Press 'Enter' to go back to main menu", completed: false)
            case 3:
                showTasks(question: "Press 'Enter' to go back to main menu", completed: true)
            case 4:
                beginTask()
            case 5:
                finishTask()
            case 6:
                deleteTask()
            case 7:
                print("Goodbye")
                return
            default:
                mainMenu()
        }
        lineSpaces(lines: 1)
        let _ :String = userInput(question: "Press 'Enter' to go back to main menu")
        mainMenu()
    }
    
    func printTasks(list: [Task]) {
        lineSpaces(lines: 1)
        
        for (index, task) in list.enumerated() {
            print("\(index + 1))" + " \(task.name) - \(task.description) " + "(\(taskExtension[index]))")
        }
    }
    
    func showTasks(question: String, completed: Bool?) {
        sortTasks()
        var usedList = allTasks
        var words = "all tasks"
        
        if completed != nil {
            usedList = completed! ? completedList : incompletedList
            words = completed! ? "completed tasks" : "incompleted tasks"
        }
        if usedList.isEmpty {
            print("The list of \(words) is empty")
            return
        }
        
        print("The list of \(words):")
        
        printTasks(list: usedList)
        lineSpaces(lines: 1)
        
        let answer :String = userInput(question: """
            \(question)
            (Enter '*' to resort the list)
            """)
        
        if answer.lowercased().contains("*") {
            sort()
            showTasks(question: question, completed: completed)
        }
        if answer.lowercased().contains("y"){
            printTasks(list: usedList)
        } else {
            print("That is not a valid input")
            return
        }
    }
    
    func sort() {
        repeat {
            filterExtension = userInput(question: """
            How would you like to sort the list?

            1) by name
            2) by starting date
            3) by due date
            4) by status
            5) by completed date
            """)
            
        } while !(1...5).contains(filterExtension)
    }
    
    func beginTask() {
        lineSpaces(lines: 1)
        let name :String  = userInput(question: "Name of task:")
        
        lineSpaces(lines: 1)
        let description: String = userInput(question: "Description of \(name):")
        lineSpaces(lines: 1)
        let dueDate :Date = userInput(question: """
            What is the task's due date?
                (example: '9/11/01 8:26 am')
            """)
        lineSpaces(lines: 1)
        
        let finalCheck :String = userInput(question: """
            Are you sure you want to begin '\(name)'?
                        (Yes/No)
            """)
        if finalCheck.lowercased().contains("y") {
            allTasks.append(Task(name: name, description: description, dueDate: dueDate))
            print(incompletedList.last!.name + " has been started, and must be completed by :" + (formatter.string(from: dueDate)))
        }
    }
    
    func finishTask() {
        
        showTasks(question: "Do you want to finish a task? (Yes/no)", completed: false)
        if incompletedList.isEmpty {
            return
        }
        
        lineSpaces(lines: 1)
        let task :Int = userInput(question: "What task number is completed?") - 1
        
        if incompletedList.count < task + 1 {
            print("That is not valid input ")
            return
        }
        let sure :String = userInput(question: """
            Are you sure '\(incompletedList[task].name)' is comepleted?
                        (Yes/No)
            """)
        
        if sure.lowercased().contains("y") {
            lineSpaces(lines: 1)
            print(incompletedList[task].name + " - has been completed")
            incompletedList[task].isCompleted = true
        }
    }
    
    func deleteTask() {
        showTasks(question: "Do you want to delete a task? (Yes/no)", completed: nil)
        if allTasks.isEmpty {
            return 
        }
        
        let taskNumber :Int = userInput(question: "What task do you want to delete?") - 1
        if allTasks.count < taskNumber {
            deleteTask()
        }
        
        let sure :String = userInput(question: """
            Are you sure you want to delete \(allTasks[taskNumber].name)?
                            (Yes/No)
            """)
        
        if sure.lowercased().contains("y") {
            print(allTasks[taskNumber].name + " - has been deleted")
            allTasks.remove(at: taskNumber)
        }
    }
}
