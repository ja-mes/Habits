//
//  Extension.swift
//  Habits
//
//  Created by James Brown on 9/22/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import Foundation

extension Date {
    func todayInt() -> Int {
        var dayInt: Int!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let day = dateFormatter.string(from: Date())
        
        switch day {
        case "Sunday":
            dayInt = 0
            break
        case "Monday":
            dayInt = 1
            break
        case "Tuesday":
            dayInt = 2
            break
        case "Wednesday":
            dayInt = 3
            break
        case "Thursday":
            dayInt = 4
            break
        case "Friday":
            dayInt = 5
            break
        case "Saturday":
            dayInt = 6
            break
        default: break
        }
        
        return dayInt!
    }
}
