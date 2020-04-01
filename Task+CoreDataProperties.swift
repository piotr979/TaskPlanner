//
//  Task+CoreDataProperties.swift
//  TaskPlanner
//
//  Created by Start on 26/03/2020.
//  Copyright © 2020 Start. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var taskName: String?
    @NSManaged public var taskTime: Int16
    @NSManaged public var taskFinishedAmt: Int16

}
