//
//  Habit+CoreDataProperties.swift
//  Habits
//
//  Created by James Brown on 10/4/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit");
    }

    @NSManaged public var lastEntry: NSDate?
    @NSManaged public var name: String?

}
