//
//  ColorsViewController.swift
//  Habits
//
//  Created by James Brown on 9/27/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class ColorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //var hasFoundCurrentBlock = false
    var indexOfBlock: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell") as? ColorTableViewCell {
            
            cell.background.backgroundColor = colors[indexPath.row]
            cell.descLbl.text = "\(days[indexPath.row]) days"

            if indexOfBlock != nil {
                if indexPath.row == indexOfBlock {
                    cell.descLbl.text = "Your here!"
                }
            } else {
                let streak = Streak.shared.streakDays
                let day = days[indexPath.row]
                
                if indexPath.row == 0 {
                    if streak < days[1] {
                        cell.descLbl.text = "Your here!"
                        indexOfBlock = indexPath.row
                    }
                } else if indexPath.row == 8 {
                    if streak >= days[days.count - 1] {
                        cell.descLbl.text = "Your here!"
                        indexOfBlock = indexPath.row
                    }
                } else {
                    let nextDay = days[indexPath.row + 1]
                    let previousDay = days[indexPath.row - 1]
                    
                    if streak < nextDay && streak > previousDay || streak == day {
                        cell.descLbl.text = "Your here!"
                        indexOfBlock = indexPath.row
                    }
                }
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
}
