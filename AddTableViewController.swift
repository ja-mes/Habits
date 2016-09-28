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
    @IBOutlet weak var skipCell: UITableViewCell!
    @IBOutlet weak var notesCell: UITableViewCell!
    @IBOutlet weak var numNotesLbl: UILabel!
    
    var habit: Habit?

    
    // MARK: setup methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        if let habit = habit {
            nameField.text = habit.name
            deleteCell.isHidden = false
            doneCell.isHidden = false
            skipCell.isHidden = false
            notesCell.isHidden = false
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
        
        if let staticIndexPath = tableView.indexPath(for: self.notesCell), staticIndexPath == indexPath {
            performSegue(withIdentifier: "NotesViewController", sender: nil)
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
            Streak.shared.deleteHabit(habit: habit)
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
        if let habit = habit {
            if Streak.shared.checkHabitDone(habit: habit) {
                Streak.shared.markAsNotDone(habit: habit)
            } else {
                Streak.shared.markAsDone(habit: habit)
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
    
}
