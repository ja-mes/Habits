//
//  CenteredTabBar.swift
//  Habits
//
//  Created by James Brown on 9/25/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class CenteredTabBar: UITabBarItem {
    
    override func awakeFromNib() {
        self.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
    
}
