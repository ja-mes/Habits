//
//  SummaryViewController.swift
//  Habits
//
//  Created by James Brown on 9/11/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var completedLbl: UILabel!
    @IBOutlet weak var timeRemaining: UILabel!
    
    var numRows: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Streak.shared.checkStreakEnded()

        numRows = Streak.shared.streakDays

        collectionView.delegate = self
        collectionView.dataSource = self
        
        let startOfDay = NSCalendar.current.startOfDay(for: Date())

        var components = DateComponents()
        components.day = 1
        components.second = -1
        
        let endOfDay = NSCalendar.current.date(byAdding: components, to: startOfDay)
        
        timeRemaining.text = "\(Date().hours(from: endOfDay!))"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        numRows = Streak.shared.streakDays
        
        completedLbl.text = "\(Streak.shared.completedHabits) of \(Streak.shared.totalHabits)"
        collectionView.reloadData()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StreakCell", for: indexPath) as?  StreakCollectionViewCell {
            cell.numLabel.text = "\(numRows - indexPath.row)"
            return cell
        }
        return UICollectionViewCell()
    }
    
}

