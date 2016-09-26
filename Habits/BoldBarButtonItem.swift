//
//  BoldBarButtonItem.swift
//  Habits
//
//  Created by James Brown on 9/25/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class BoldBarButtonItem: UIBarButtonItem {
    override func awakeFromNib() {
        
        if let font = UIFont(name: "AvenirNext-Medium", size: 17) {
            self.setTitleTextAttributes([NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.black], for: UIControlState.normal)
            self.setTitleTextAttributes([NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.gray], for: UIControlState.disabled)
        }
    }
}
