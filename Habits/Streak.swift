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
            if newValue <= 0 {
                _streakDays = 0
            } else {
                _streakDays = newValue
            }
            
            UserDefaults.standard.set(_streakDays, forKey: STREAK_KEY)
        }
    }
    
    var completedHabits: Int {
        get {
            var num = 0
            let fetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
            let today = NSCalendar.current.startOfDay(for: Date())
            let datePredicate = NSPredicate(format: "lastEntry > %@", today as CVarArg)

            fetchRequest.predicate = datePredicate
            
            do {
                num = try context.count(for: fetchRequest)
            } catch {
                fatalError("Unable to count habits")
            }
            
            return num
        }
    }
    
    var totalHabits: Int {
        let fetchRequest: NSFetchRequest<Habit> = Habit.fetchRequest()
        let dayInt = Date().todayInt()
        fetchRequest.predicate = NSPredicate(format: "selectedDays CONTAINS[c] %@", "\(dayInt)" as CVarArg)
        
        _totalHabits = 0
        
        do {
            _totalHabits = try context.count(for: fetchRequest)
        } catch {
            print("JAMES: unable to count habits")
        }
        
        if _totalHabits < completedHabits {
            return completedHabits
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
        
        
        // default last entry to yesterday
        if UserDefaults.standard.object(forKey: LAST_ENTRY_KEY) == nil {
            let yesterday = NSCalendar.current.date(byAdding: .day, value: -1, to: Date())!
            UserDefaults.standard.set(yesterday, forKey: LAST_ENTRY_KEY)
        }
        
    }
    
    func markAsDone(habit: Habit) {
        habit.lastEntry = Date()
        ad.saveContext()
        
        checkStreakCompleted(inc: true)
    }
    
    func markAsNotDone(habit: Habit) {
        if let yesterday = NSCalendar.current.date(byAdding: .day, value: -1, to: Date()) {
            habit.lastEntry = yesterday
            ad.saveContext()
            
            checkStreakCompleted(inc: false)
        }
    }
    
    func checkHabitDone(habit: Habit) -> Bool {
        let today = NSCalendar.current.startOfDay(for: Date())
        let compare = NSCalendar.current.compare(today, to: habit.lastEntry, toGranularity: .nanosecond).rawValue
        
        if compare == 1 {
            return false
        }
        
        return true
    }
    
    func deleteHabit(habit: Habit) {
        context.delete(habit)
        ad.saveContext()
        checkStreakCompleted(inc: true)
    }
    
    
    func checkStreakCompleted(inc: Bool) {
        
        checkStreakEnded()
        
        if inc && totalHabits == completedHabits {
            
            if !NSCalendar.current.isDate(lastEntry, inSameDayAs: Date()) && completedHabits != 0  {
                streakDays += 1
                lastEntry = Date()
            }
        } else if !inc && completedHabits == totalHabits - 1 {
            streakDays += -1
            lastEntry = NSCalendar.current.date(byAdding: .day, value: -1, to: Date())!
        }
        
    }
    
    func checkStreakEnded() {
        let twoDaysAgo = NSCalendar.current.date(byAdding: .day, value: -2, to: Date())!
        
        if NSCalendar.current.isDate(twoDaysAgo, inSameDayAs: lastEntry) {
            
            streakDays = 0
        }

    }
    
}






