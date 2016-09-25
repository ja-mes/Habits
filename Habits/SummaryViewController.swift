//
//  SummaryViewController.swift
//  Habits
//
//  Created by James Brown on 9/11/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var completedLbl: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadStreak(notification:)), name: NSNotification.Name(rawValue: "reloadStreak"), object: nil)
        
        Streak.shared.checkStreakEnded()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        completedLbl.text = "\(Streak.shared.completedHabits) of \(Streak.shared.totalHabits)"
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Streak.shared.streakDays + 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StreakCell", for: indexPath) as?  StreakCollectionViewCell {
            cell.numLabel.text = "\(Streak.shared.streakDays - indexPath.row)"
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    
    func loadStreak(notification: NSNotification){
        self.collectionView.reloadData()
    }
    
}

