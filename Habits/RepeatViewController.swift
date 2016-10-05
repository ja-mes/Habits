//
//  RepeatViewController.swift
//  Habits
//
//  Created by James Brown on 10/2/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class RepeatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!

    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var selectedDays = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        selectedDays = daysOfWeek
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RepeatCell") {
            cell.textLabel?.text = daysOfWeek[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                cell.textLabel?.alpha = 0.2
                
                if let index = selectedDays.index(of: daysOfWeek[indexPath.row]) {
                    selectedDays.remove(at: index)
                }
            } else if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                cell.textLabel?.alpha = 1.0
                
                selectedDays.append(daysOfWeek[indexPath.row])
            }
        }
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "selected_days"), object: selectedDays)
    }
    
}
