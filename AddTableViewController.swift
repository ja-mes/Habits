//
//  AddTableViewController.swift
//  Habits
//
//  Created by James Brown on 9/18/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController {
    
    @IBOutlet weak var nameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        nameField.becomeFirstResponder()
    }
    
    // MARK: IBActions
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let habit = Habit(context: context)
        
        if nameValid() {
            habit.name = nameField.text
            habit.lastEntry = Date()
        }
        
        ad.saveContext()
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
