//
//  CustomBarButtonItem.swift
//  Habits
//
//  Created by James Brown on 9/25/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class CustomBarButtonItem: UIBarButtonItem {
    override func awakeFromNib() {
        
        if let font = UIFont(name: "Avenir Next", size: 18) {
            self.setTitleTextAttributes([NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.black], for: UIControlState.normal)
            self.setTitleTextAttributes([NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.gray], for: UIControlState.disabled)
        }
        
    }
}
