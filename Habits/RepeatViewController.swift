//
//  RepeatViewController.swift
//  Habits
//
//  Created by James Brown on 10/2/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class RepeatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    var selectedDays = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RepeatCell") {
            if selectedDays.index(of: indexPath.row + 1) != nil {
                cell.accessoryType = .checkmark
            }
            
            cell.textLabel?.text = DAYS_OF_WEEK[indexPath.row]
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
                
                if let index = selectedDays.index(of: indexPath.row) {
                    selectedDays.remove(at: index)
                }
            } else if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                cell.textLabel?.alpha = 1.0
                
                selectedDays.append(indexPath.row)
            }
        }
    }
}
