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
    @IBOutlet weak var deleteCell: UITableViewCell!
    
    var habit: Habit?

    
    // MARK: setup methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        if let habit = habit {
            nameField.text = habit.name
            deleteCell.isHidden = false
        } else {
            nameField.becomeFirstResponder()
        }
    }
    
    // MARK: IBActions
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let item: Habit!
        
        if let habit = habit {
            item = habit
        } else {
            item = Habit(context: context)
        }
        
        if nameValid() {
            item.name = nameField.text
            let yesterday = NSCalendar.current.date(byAdding: .day, value: -1, to: Date())
            item.lastEntry = yesterday!
            
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
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        if let habit = habit {
            context.delete(habit)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
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
