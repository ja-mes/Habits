//
//  CircleView.swift
//  Habits
//
//  Created by James Brown on 9/25/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class CircleView: UIView {

    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }

}
