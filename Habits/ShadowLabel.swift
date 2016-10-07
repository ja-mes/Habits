//
//  ShadowLabel.swift
//  Habits
//
//  Created by James Brown on 10/6/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class ShadowLabel: UILabel {

    override func awakeFromNib() {
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
    }

}
