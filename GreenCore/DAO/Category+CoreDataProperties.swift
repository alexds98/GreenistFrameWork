//
//  Category+CoreDataProperties.swift
//  Homer
//
//  Created by Lorenzo Fasolino on 14/02/2020.
//  Copyright © 2020 Lorenzo Fasolino. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var tasks: NSSet?
    
    func addTask(task: Task){
        self.addToTasks(task)
    }

}

// MARK: Generated accessors for tasks
extension Category {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
