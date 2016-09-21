//
//  Streak.swift
//  Habits
//
//  Created by James Brown on 9/20/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import Foundation

class Streak {
    static let shared = Streak()
    
    var streakDays = 0
    var completedHabits = 0
    
    func setupDefaults() {
        if UserDefaults.standard.object(forKey: STREAK_KEY) == nil {
            UserDefaults.standard.set(0, forKey: STREAK_KEY)
            streakDays = 0
        }
        
        if UserDefaults.standard.object(forKey: COMPLETED_KEY) == nil {
            UserDefaults.standard.set(0, forKey: COMPLETED_KEY)
        }
    }
    
    func incCompleted() -> Int {
        streakDays += 1
        UserDefaults.standard.set(streakDays, forKey: COMPLETED_KEY)
        return streakDays
    }
    
    func decCompleted() -> Int {
        streakDays -= 1
        UserDefaults.standard.set(streakDays, forKey: COMPLETED_KEY)
        return streakDays
    }
}

