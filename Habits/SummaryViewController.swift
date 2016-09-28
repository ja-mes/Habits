//
//  SummaryViewController.swift
//  Habits
//
//  Created by James Brown on 9/11/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    @IBOutlet weak var completedLbl: UILabel!
    @IBOutlet weak var streakCount: UILabel!
    @IBOutlet weak var circle: CircleView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Streak.shared.checkStreakEnded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let streak = Streak.shared.streakDays
        
        Streak.shared.streakDays = 1000

        completedLbl.text = "\(Streak.shared.completedHabits) of \(Streak.shared.totalHabits)"
        streakCount.text = "\(streak)"
        
        for (i, _) in days.enumerated() {
            if i + 1 == days.count {
                circle.backgroundColor = colors[i]
                break
            } else {
                if streak < days[i + 1] {
                    circle.backgroundColor = colors[i]
                    break
                }
            }
        }
    }
    
}

