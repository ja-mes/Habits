//
//  Streak.swift
//  Habits
//
//  Created by James Brown on 9/20/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import Foundation
import CoreData

class Streak {
    static let shared = Streak()
    
    private var _streakDays = 0
    private var _completedHabits = 0
    private var _totalHabits = 0
    
    var streakDays: Int {
        get {
            if let num = UserDefaults.standard.object(forKey: STREAK_KEY) as? Int {
                _streakDays = num
            }
            return _streakDays
        }
        set {
            _streakDays = newValue
            UserDefaults.standard.set(_streakDays, forKey: STREAK_KEY)
        }
    }
    
    var completedHabits: Int {
        get {
            if let num = UserDefaults.standard.object(forKey: COMPLETED_KEY) as? Int {
                _completedHabits = num
            }
            
            return _completedHabits
        }
        set {
            let total = totalHabits
            
            if newValue == total {
                streakDays += 1
            } else if _completedHabits == total && newValue != total {
                streakDays -= 1
            }
            _completedHabits = newValue
            UserDefaults.standard.set(_completedHabits, forKey: COMPLETED_KEY)
        }
    }
    
    var totalHabits: Int {
        let fetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
        _totalHabits = 0
        
        do {
            _totalHabits = try context.count(for: fetchRequest)
        } catch {
            print("JAMES: unable to count habits")
        }
        
        return _totalHabits
    }
    
    var lastEntry: Date {
        get {
            return UserDefaults.standard.object(forKey: LAST_ENTRY_KEY) as! Date
        }
        set {
            
            UserDefaults.standard.set(newValue, forKey: LAST_ENTRY_KEY)
        }
    }
    
    
    func setupDefaults() {
        // default streak to 0
        if UserDefaults.standard.object(forKey: STREAK_KEY) == nil {
            UserDefaults.standard.set(0, forKey: STREAK_KEY)
            streakDays = 0
        }
        
        
        // default completed to 0
        if UserDefaults.standard.object(forKey: COMPLETED_KEY) == nil {
            UserDefaults.standard.set(0, forKey: COMPLETED_KEY)
        }
        
        // default last entry to yesterday
        if UserDefaults.standard.object(forKey: LAST_ENTRY_KEY) == nil {
            let yesterday = NSCalendar.current.date(byAdding: .day, value: -1, to: Date())!
            UserDefaults.standard.set(yesterday, forKey: LAST_ENTRY_KEY)
            
        }
        
    }
    
    func checkStreakEnded() {
        let twoDaysAgo = NSCalendar.current.date(byAdding: .day, value: -2, to: Date())!
        
        if NSCalendar.current.isDate(twoDaysAgo, inSameDayAs: lastEntry) {
            streakDays = 0
        }
    }
    
}






