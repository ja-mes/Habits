//
//  AddTableViewController.swift
//  Habits
//
//  Created by James Brown on 9/18/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController {
    
    // MARK: variables
    @IBOutlet weak var nameField: UITextField!
    
    var habit: Habit?

    
    // MARK: setup methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        if let habit = habit {
            nameField.text = habit.name
        } else {
            nameField.becomeFirstResponder()
        }
    }
    
    // MARK: IBActions
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let habit = Habit(context: context)
        
        if nameValid() {
            habit.name = nameField.text
            let yesterday = NSCalendar.current.date(byAdding: .day, value: -1, to: Date())
            habit.lastEntry = yesterday!
            
            ad.saveContext()
            
            let total = Streak.shared.totalHabits
            let completed = Streak.shared.completedHabits
            
            if Streak.shared.streakDays != 0 && completed >= total - 1 {
                Streak.shared.streakDays -= 1
            }
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nameFieldChanged(_ sender: UITextField) {
        if nameValid() {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    // MARK: functions
    func nameValid() -> Bool {
        if let text = nameField.text, text.isEmpty == false {
            return true
        } else {
            return false
        }
    }
    
}
