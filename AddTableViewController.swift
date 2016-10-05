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
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var deleteCell: UITableViewCell!
    @IBOutlet weak var doneCell: UITableViewCell!
    @IBOutlet weak var repeatCell: UITableViewCell!
    @IBOutlet weak var selectedDaysLbl: UILabel!
    
    var habit: Habit?
    //var selectedDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    
    // MARK: setup methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateDays(notification:)), name: Notification.Name(rawValue: "selected_days"), object: nil)
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        if let habit = habit {
            nameField.text = habit.name
            deleteCell.isHidden = false
            doneCell.isHidden = false
        }
                
        if let habit = habit {
            if Streak.shared.checkHabitDone(habit: habit) {
                doneButton.setTitle("Not Done", for: .normal)
            } else {
                doneButton.setTitle("Done", for: .normal)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if habit == nil {
            nameField.becomeFirstResponder()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.indexPath(for: repeatCell) == indexPath {
            performSegue(withIdentifier: "RepeatViewController", sender: nil)
        }
    }
    
    // MARK: IBActions
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let item: Habit!
        
        if let habit = habit {
            item = habit
        } else {
            item = Habit(context: context)
            
            let yesterday = NSCalendar.current.date(byAdding: .day, value: -1, to: Date())
            item.lastEntry = yesterday! as NSDate?
        }
        
        if nameValid() {
            item.name = nameField.text
            ad.saveContext()

            Streak.shared.checkStreakCompleted(inc: false)
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
            let deleteAlert = UIAlertController(title: "Are you sure you want to delete this habit?", message: "There is no undo!", preferredStyle: .alert)
            
            deleteAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                Streak.shared.deleteHabit(habit: habit)
                _ = self.navigationController?.popViewController(animated: true)
            }))
            
            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                
            }))
            
            present(deleteAlert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
        if let habit = habit {
            if Streak.shared.checkHabitDone(habit: habit) {
                Streak.shared.markAsNotDone(habit: habit)
            } else {
                Streak.shared.markAsDone(habit: habit)
            }
            
            if UserDefaults.standard.object(forKey: "user_info_swipe_table") == nil {
                let alert = UIAlertController(title: "You can also mark habits as done by swiping left on them in the table.", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    UserDefaults.standard.set(true, forKey: "user_info_swipe_table")
                    self.dismiss(animated: true, completion: nil)
                    _ = self.navigationController?.popViewController(animated: true)
                }))
                
                present(alert, animated: true, completion: nil)
            }

            
            _ = navigationController?.popViewController(animated: true)
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
    
    func updateDays(notification: Notification) {
        
        if let selectedDays = notification.object as? [String] {
            let dateFormatter = DateFormatter()
            dateFormatter.weekdaySymbols = DAYS_OF_WEEK
            
            print(selectedDays)
            
            for (i, _) in selectedDays.enumerated() {
                var test = dateFormatter.weekdaySymbols[i]
                print(test)
            }
            
            
        }
    }
    
}





















