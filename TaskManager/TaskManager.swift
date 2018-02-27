//
//  TaskManager.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/22/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

class TaskManager: TimeDeclaration  {
    let tasks = TaskList()
    var filters = TaskFilter(filter: [Task]())
    var taskExtension = 1
    
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
        let _ : String = userInput(question: "Press 'Enter' to go back to main menu")
        mainMenu()
    }
    
    func printTasks(list: [Task]) {
        lineSpaces(lines: 1)
        
        for (index, task) in list.enumerated() {
            print("\(index + 1))" + " \(task.name) - \(task.description) " + "(\(filters.taskExtention[index]))")
        }
    }
    
    func showTasks(question: String, completed: Bool?) {
        var usedList = tasks.allList
        var words = "all tasks"
        
        if completed != nil {
            usedList = completed! ? tasks.completedList : tasks.uncompletedList
            words = completed! ? "completed tasks" : "uncompleted tasks"
        }
        if usedList.isEmpty {
            print("The list of \(words) is empty")
            return
        }
        
        print("The list of \(words):")
        filters = TaskFilter(filter: usedList)
        tasks.allList = filters.filter(filter: taskExtension)
        printTasks(list: usedList)
        lineSpaces(lines: 1)
        
        let answer: String = userInput(question: """
            \(question)
            (Enter '*' to resort the list)
            """)
        
        if answer.lowercased().contains("*") {
            sorting(list: usedList)
            showTasks(question: question, completed: completed)
        }
        if answer.lowercased().contains("y"){
            printTasks(list: usedList)
            return
        } else {
            mainMenu()
        }
    }
    
    func sorting(list: [Task]) {
        filters = TaskFilter(filter: list)
        
        repeat {
            taskExtension = userInput(question: """
            How would you like to sort the list?

            1) by name
            2) by starting date
            3) by due date
            4) by status
            5) by completed date
            """)
            
        } while !(1...5).contains(taskExtension)
    }
    
    func beginTask() {
        lineSpaces(lines: 1)
        let name: String  = userInput(question: "Name of task:")
        
        lineSpaces(lines: 1)
        let description: String = userInput(question: "Description of \(name):")
        lineSpaces(lines: 1)
        let dueDate: Date = userInput(question: """
            What is the task's due date?
                (example: '9/11/01 8:26 am')
            """)
        lineSpaces(lines: 1)
        
        let finalCheck: String = userInput(question: """
            Are you sure you want to begin '\(name)'?
                        (Yes/No)
            """)
        if finalCheck.lowercased().contains("y") {
            tasks.allList.append(Task(name: name, description: description, dueDate: dueDate))
            print(tasks.uncompletedList.last!.name + " has been started, and must be completed by :" + (formatter.string(from: dueDate)))
        }
    }
    
    func finishTask() {
        
        showTasks(question: "Do you want to finish a task?", completed: false)
        if tasks.uncompletedList.isEmpty {
            return
        }
        
        lineSpaces(lines: 1)
        let task: Int = userInput(question: "What task number is completed?") - 1
        
        if tasks.uncompletedList.count < task + 1 {
            return
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
        showTasks(question: "Do you want to delete a task?", completed: nil)
        if tasks.allList.isEmpty {
            return
        }
        
        let taskNumber: Int = userInput(question: "What task do you want to delete?") - 1
        if tasks.allList.count < taskNumber {
            deleteTask()
        }
        
        let sure: String = userInput(question: """
            Are you sure you want to delete \(tasks.allList[taskNumber].name)?
                            (Yes/No)
            """)
        
        if sure.lowercased().contains("y") {
            print(tasks.allList[taskNumber].name + " - has been deleted")
            tasks.allList.remove(at: taskNumber)
        }
    }
}


