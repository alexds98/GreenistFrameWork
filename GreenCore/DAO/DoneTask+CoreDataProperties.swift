//
//  DoneTask+CoreDataProperties.swift
//  Homer
//
//  Created by Lorenzo Fasolino on 14/02/2020.
//  Copyright © 2020 Lorenzo Fasolino. All rights reserved.
//
//

import Foundation
import CoreData


extension DoneTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DoneTask> {
        return NSFetchRequest<DoneTask>(entityName: "DoneTask")
    }

    @NSManaged public var doneDate: Date?
    @NSManaged public var task: Task?

}
