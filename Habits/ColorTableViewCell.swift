//
//  ColorTableViewCell.swift
//  Habits
//
//  Created by James Brown on 9/27/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import UIKit

class ColorTableViewCell: UITableViewCell {

    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var background: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
