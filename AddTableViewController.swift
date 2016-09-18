//
//  AddTableViewController.swift
//  Habits
//
//  Created by James Brown on 9/18/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: IBActions
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}
