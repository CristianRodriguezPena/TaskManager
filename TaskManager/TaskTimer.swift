//
//  TaskTimer.swift
//  TaskManager
//
//  Created by Cristian Rodriguez on 2/22/18.
//  Copyright © 2018 Cristian Rodriguez. All rights reserved.
//

import Foundation

/*
 
 - This is bad naming. Timer is already taken and implies it records small amounts of time. Also, does Timer really repesent what this class means? If something has an initDate and a dueDate is it a Timer? What does that even mean?
 - Would recommend renaming initDate to checkOutDate
 - No space after colon
 
 */

class Timer {
    let initDate : Date
    let dueDate : Date
    
    init(dueDate: Date) {
        self.initDate = Date()
        self.dueDate = dueDate
    }
}

/*
    - The naming on this especially doesn't make sense. I'm not quite sure what this is even used for. Why wouldn't you just create a formatter whenever you need? If you really hated creating formatters, just make an extension to the DateFormatter class. Don't make a hacky wrapper class.
 */

class TimeDeclaration {
    let formatter = DateFormatter()
    init() {
        formatter.dateFormat = "MM/d/yy H:mm a"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
    }
}
