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
    
    var selectedDays = [0, 1, 2, 3, 4, 5, 6]

    
    // MARK: setup methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateDays(notification:)), name: Notification.Name(rawValue: "selected_days"), object: nil)
        
        if let habit = habit {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "selected_days"), object: habit.selectedDays.components(separatedBy: ",").map({Int($0)!}))
            
            nameField.text = habit.name
            deleteCell.isHidden = false
            doneCell.isHidden = false
            
            if Streak.shared.checkHabitDone(habit: habit) {
                doneButton.setTitle("Mark as incomplete", for: .normal)
            } else {
                doneButton.setTitle("Mark as done", for: .normal)
            }
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RepeatViewController" {
            if let destination = segue.destination as? RepeatViewController {
                destination.selectedDays = selectedDays
            }
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
            item.lastEntry = yesterday!
        }
        
        item.selectedDays = selectedDays.map({"\($0)"}).joined(separator: ",")
        
        if nameValid() {
            item.name = nameField.text
            ad.saveContext()

            Streak.shared.checkStreakCompleted(inc: false)
            Streak.shared.checkStreakCompleted(inc: true)
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
            let deleteAlert = UIAlertController(title: "Confirmation", message: "Are you sure you want to delete this habit?", preferredStyle: .alert)
            
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
        if let selectedDays = notification.object as? [Int] {
            self.selectedDays = selectedDays
            
            if selectedDays.count == DAYS_OF_WEEK.count {
                selectedDaysLbl.text = "Daily"
            } else {
                var dayLetters = [String]()
                
                for day in selectedDays {
                    switch day {
                    case 0:
                        dayLetters.append("S")
                        break
                    case 1:
                        dayLetters.append("M")
                        break
                    case 2:
                        dayLetters.append("T")
                        break
                    case 3:
                        dayLetters.append("W")
                        break
                    case 4:
                        dayLetters.append("T")
                        break
                    case 5:
                        dayLetters.append("F")
                        break
                    case 6:
                        dayLetters.append("S")
                        break
                    default: break
                        
                    }
                    
                    selectedDaysLbl.text = dayLetters.joined(separator: "")
                }
            }
        }
        
    }
    
}
