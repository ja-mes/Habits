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
    
    let colors = [
        UIColor(red: 244/255, green: 67/255, blue: 54/255, alpha: 1.0),
        UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
        UIColor(red: 233/255, green: 30/255, blue: 99/255, alpha: 1.0),
        UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0),
        UIColor(red: 139/255, green: 195/255, blue: 74/255, alpha: 1.0),
        UIColor(red: 0/255, green: 150/255, blue: 136/255, alpha: 1.0),
        UIColor(red: 255/255, green: 87/255, blue: 34/255, alpha: 1.0),
        UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0),
    ]
    
    let labels = ["Your here!", "7", "14", "30", "60", "100", "180", "360"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell") as? ColorTableViewCell {
            
            cell.background.backgroundColor = colors[indexPath.row]
            cell.descLbl.text = labels[indexPath.row]
            
            return cell
        }
        
        return UITableViewCell()
    }
}
