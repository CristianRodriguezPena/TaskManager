//
//  TaskManager.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/20/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class TaskManager:TimeDeclaration {
    var tasks = TaskList()
    
    func launch() {
        lineSpaces(lines: 1)
        print("\\Welcome to Task Manager/")
        lineSpaces(lines: 1)
        presetTasks()
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
        
        if intResponse > 7 || intResponse < 1 {
            mainMenu()
        }
            switch intResponse {
            case 1:
                showTasks(complete: nil)
            case 2:
                showTasks(complete: false)
            case 3:
                showTasks(complete: true)
            case 4:
                beginTask()
            case 5:
                finishTask()
            case 6:
                deleteTask()
            case 7:
                print("Goodbye")
                break
            default:
                mainMenu()
        }
        lineSpaces(lines: 1)
        print("Press 'Enter' to go back to main menu")
        let _: String = readLine()!
        mainMenu()
    }
    
    func presetTasks() {
        tasks.list.append(Task(name: "Finish the task Manager", description: "Add 7 options in the task manager", dueDate: formatter.date(from: "3/2/18 5:00 pm")!))
    }
    
    func showTasks(complete: Bool?) {
        var usedList = tasks.allList
        var words = "all tasks"
        if complete != nil {
            usedList = complete! ? tasks.completedList : tasks.uncompletedList
            words = complete! ? "completed tasks" : "uncompleted tasks"
        }
        
        if usedList.isEmpty {
            print("The list of \(words) is empty")
            return
        }
        
        print("The list of \(words):")
        printTasks(list: usedList)
    }
    
    func printTasks(list: [Task]) {
        lineSpaces(lines: 1)
        
        for (index, task) in list .enumerated() {
            print("\(index + 1)) \(task.name) - \(task.description)\(task.status)")
        }
    }
    
    func beginTask() {
        lineSpaces(lines: 1)
        let name: String  = userInput(question: """
            (Enter 'Esc' to go to Main menu)
            Name of task:
            """)
        
        if name.lowercased().contains("esc") {
            mainMenu()
        }
        
        lineSpaces(lines: 1)
        let description: String = userInput(question: "Description of \(name):")
        lineSpaces(lines: 1)
        let dueDate: Date = userInput(question: """
            What is the task's due date?
                (example: '9/11/01 8:26 am')
            """)
        
        let finalCheck: String = userInput(question: """
            Are you sure you want to begin '\(name)'?
                        (Yes/No)
            """)
        if finalCheck.lowercased().contains("y") {
            tasks.list.append(Task(name: name, description: description, dueDate: dueDate))
            lineSpaces(lines: 1)
            print(tasks.uncompletedList.last!.name + " has been started, and must be completed by : \(formatter.string(from: dueDate))")
        }
    }
    
    func finishTask() {
        showTasks(complete: false)
        if tasks.uncompletedList.isEmpty {
            mainMenu()
        }
        
        lineSpaces(lines: 1)
        let task: Int = userInput(question: "What task number is completed?") - 1
        
        if tasks.uncompletedList.count < task {
            mainMenu()
        }
        let sure: String = userInput(question: """
            Are you sure '\(tasks.uncompletedList[task].name)' is comepleted?
                        (Yes/No)
            """)
        
        if sure.lowercased().contains("y") {
            lineSpaces(lines: 1)
            print(tasks.uncompletedList[task].name + " - has been completed")
            tasks.uncompletedList[task].isCompleted = true
        }
    }
    
    func deleteTask() {
        showTasks(complete: nil)
        if tasks.allList.isEmpty {
            mainMenu()
        }
        
        let taskNumber: Int = userInput(question: """
            What task do you want to delete?
            (Enter 'Esc' to go to Main menu)
            """) - 1
        if tasks.allList.count < taskNumber {
            mainMenu()
        }
        
        let sure: String = userInput(question: """
            Are you sure you want to delete \(tasks.allList[taskNumber].name)?
                            (Yes/No)
            """)
        
        if sure.lowercased().contains("y") {
            print(tasks.allList[taskNumber].name + " - has been deleted")
            tasks.list.remove(at: taskNumber)
        }
    }
}


