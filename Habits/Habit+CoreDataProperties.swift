//
//  Habit+CoreDataProperties.swift
//  Habits
//
//  Created by James Brown on 9/18/16.
//  Copyright © 2016 James Brown. All rights reserved.
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit");
    }

    @NSManaged public var name: String?
    @NSManaged public var lastEntry: Date
    @NSManaged public var selectedDays: String?
}
