//
//  Achievement+CoreDataProperties.swift
//  Homer
//
//  Created by Lorenzo Fasolino on 14/02/2020.
//  Copyright © 2020 Lorenzo Fasolino. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


extension Achievement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Achievement> {
        return NSFetchRequest<Achievement>(entityName: "Achievement")
    }

    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var unlocked: Bool
    @NSManaged public var desc: String?
    @NSManaged public var goals: NSSet?
    
    func getIcon() -> UIImage?{
        getIcon(saturated: self.unlocked)
    }
    
    func getIcon(saturated: Bool) -> UIImage?{
        let iconName = self.image
        if(!saturated){
            return UIImage(named: iconName!+"MedalIconDesaturated")
        }
        else{
            return UIImage(named: iconName!+"MedalIcon")
        }
    }
    
//    func getMedalIcon() -> UIImage?{
//        let iconName = self.image
//         if(!self.unlocked){
//             return UIImage(named: iconName! + "MedalIconDesaturated")
//         }
//         else{
//             return UIImage(named: iconName! + "MedalIcon")
//         }
//    }
    
    func checkDone(appContext: NSManagedObjectContext) -> Bool{
        
        if(self.unlocked){
            return true
        }
        
        
        for goal in goals!{
           let g = goal as! Goal
            if(!g.checkDone(appContext: appContext)){
                return false
            }
            
        }
        
        self.unlocked = true
        PMAchievement.saveContext(appContext: appContext)
        
        return true
        
    }

}

// MARK: Generated accessors for goals
extension Achievement {

    @objc(addGoalsObject:)
    @NSManaged public func addToGoals(_ value: Goal)

    @objc(removeGoalsObject:)
    @NSManaged public func removeFromGoals(_ value: Goal)

    @objc(addGoals:)
    @NSManaged public func addToGoals(_ values: NSSet)

    @objc(removeGoals:)
    @NSManaged public func removeFromGoals(_ values: NSSet)

}
