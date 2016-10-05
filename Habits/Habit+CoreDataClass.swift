//
//  Habit+CoreDataClass.swift
//  Habits
//
//  Created by James Brown on 10/4/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import Foundation
import CoreData


public class Habit: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.days = daysOfWeek
    }
    
    public override func awakeFromFetch() {
        
    }
}
