//
//  Goal+CoreDataProperties.swift
//  Homer
//
//  Created by Lorenzo Fasolino on 18/02/2020.
//  Copyright © 2020 Lorenzo Fasolino. All rights reserved.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var below: Bool
    @NSManaged public var category: String?
    @NSManaged public var goal: Int32
    @NSManaged public var done: Bool
    @NSManaged public var achivement: Achievement?
    @NSManaged public var task: Task?
    
    func checkDone(appContext: NSManagedObjectContext) -> Bool{
        if(done){
            return true
        }else{
            if(PMGoal.verifyGoal(goal: self, appContext: appContext)){
                self.done = true
                PMGoal.saveContext(appContext: appContext)
                return true
            }else{
                return false
            }
        }
    }

}
