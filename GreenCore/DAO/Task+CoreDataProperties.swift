//
//  Task+CoreDataProperties.swift
//  Homer
//
//  Created by Lorenzo Fasolino on 16/02/2020.
//  Copyright © 2020 Lorenzo Fasolino. All rights reserved.
//
//

import CoreData
import Foundation
import UIKit

extension Task {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var desc: String?
    @NSManaged public var doneNum: Int32
    @NSManaged public var ecoPoints: Int32
    @NSManaged public var savings: Float
    @NSManaged public var state: String?
    @NSManaged public var weekly: Bool
    @NSManaged public var priority: Int32
    @NSManaged public var id: Int32
    @NSManaged public var category: Category?
    @NSManaged public var goals: NSSet?

    public func getIcon(_ desaturated: Bool) -> UIImage? {
        let iconName = category!.image
        if desaturated {
            return UIImage(named: iconName! + "_desaturated")
        } else {
            return UIImage(named: iconName!)
        }
    }

    public func check(appContext: NSManagedObjectContext) {
        // newDoneTask has a @discardableResult
        PMDoneTask.newDoneTask(task: self, appContext: appContext)
        PMDoneTask.saveContext(appContext: appContext)
        doneNum += 1
        PMTask.saveContext(appContext: appContext)
        let user = PMUser.fetchUser(appContext: appContext)
        user.totSavings += savings
        user.totEcoPoints += ecoPoints
        PMUser.saveContext(appContext: appContext)

        let achievements = PMAchievement.fetchLocked(appContext: appContext)

        for achievement in achievements {
            if achievement.checkDone(appContext: appContext) {
                print("premio ricevuto")
                
                let ac:[String: Achievement] = ["achievement": achievement]
                
                NotificationCenter.default.post(name: Notification.Name("PremioRicevuto"), object: nil, userInfo: ac)
                
                
            }
        }
    }

    public func unCheck(appContext: NSManagedObjectContext) {
        var doneTasks: [DoneTask]

        if weekly {
            doneTasks = PMDoneTask.fetchWeeklyTask(task: self, appContext: appContext)
        } else {
            doneTasks = PMDoneTask.fetchByTodayAndTask(task: self, appContext: appContext)
        }

        for doneTask in doneTasks {
            PMDoneTask.deleteDoneTask(doneTask: doneTask, appContext: appContext)
        }

        PMDoneTask.saveContext(appContext: appContext)

        doneNum -= 1
        PMTask.saveContext(appContext: appContext)

        let user = PMUser.fetchUser(appContext: appContext)
        user.totSavings -= savings

        if user.totSavings < 0 {
            user.totSavings = 0
        }
        user.totEcoPoints -= ecoPoints
        PMUser.saveContext(appContext: appContext)
    }

    public func disable(appContext: NSManagedObjectContext) {
        state = "disabled"
        PMTask.saveContext(appContext: appContext)
    }

    public func enable(appContext: NSManagedObjectContext) {
        state = "enabled"
        PMTask.saveContext(appContext: appContext)
    }

    public func isChecked(appContext: NSManagedObjectContext) -> Bool {
        if weekly {
            let doneTasks = PMDoneTask.fetchWeeklyTask(task: self, appContext: appContext)

            if !doneTasks.isEmpty {
                return true
            }
            return false

        } else {
            let doneTasks = PMDoneTask.fetchByTodayAndTask(task: self, appContext: appContext)

            if !doneTasks.isEmpty {
                return true
            }
            return false
        }
    }

    public func checkForPriority(appContext: NSManagedObjectContext) {
        if priority > 0 {
            var doneTasks: [DoneTask]

            if weekly {
                doneTasks = PMDoneTask.fetchDoneTaskOfPreviousWeek(task: self, appContext: appContext)
            } else {
                doneTasks = PMDoneTask.fetchDoneTaskOfPreviousDay(task: self, appContext: appContext)
            }

            if doneTasks.count <= 0 {
                priority = 0
                PMTask.saveContext(appContext: appContext)
            }
        }
    }
}

// MARK: Generated accessors for goals

extension Task {
    @objc(addGoalsObject:)
    @NSManaged public func addToGoals(_ value: Goal)

    @objc(removeGoalsObject:)
    @NSManaged public func removeFromGoals(_ value: Goal)

    @objc(addGoals:)
    @NSManaged public func addToGoals(_ values: NSSet)

    @objc(removeGoals:)
    @NSManaged public func removeFromGoals(_ values: NSSet)
}
