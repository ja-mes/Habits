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
            
            return cell
        }
        
        return UITableViewCell()
    }
}
