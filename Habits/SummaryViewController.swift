//
//  SummaryViewController.swift
//  Habits
//
//  Created by James Brown on 9/11/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var completedLbl: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Streak.shared.checkStreakEnded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        completedLbl.text = "\(Streak.shared.completedHabits) of \(Streak.shared.totalHabits)"
    }
    
}

