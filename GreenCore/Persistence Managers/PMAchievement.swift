//
//  PMUser.swift
//  Homer
//
//  Created by Lorenzo Fasolino on 14/02/2020.
//  Copyright © 2020 Lorenzo Fasolino. All rights reserved.
//

import Foundation
import CoreData

import UIKit

public class PMAchievement{
    
    static let tableName = "Achievement"

    
    @discardableResult
    public static func newAchievement(imageName: String, name: String, desc: String, appContext: NSManagedObjectContext) -> Achievement{
        let context = appContext
        
        let achievement = NSEntityDescription.insertNewObject(forEntityName: tableName, into: context) as! Achievement
        
        achievement.image = imageName
        achievement.name = name
        achievement.desc = desc
        achievement.unlocked = false
        achievement.goals = NSSet()
        
        
        return achievement
    }
    
    public static func fetchAllAchievement(appContext: NSManagedObjectContext) -> [Achievement]{
        var achievements: [Achievement] = []
        
        let context = appContext
        
        let fetchRequest = NSFetchRequest<Achievement>(entityName: tableName)
        
        do{
            
            try achievements = context.fetch(fetchRequest)
            
        } catch let error as NSError{
            
            print("Errore in fetch \(error.code)")
            
        }
        
        return achievements
        
    }
    
    public static func fetchByName(name: String, appContext: NSManagedObjectContext) -> [Achievement]{
           var achievements: [Achievement] = []
           
           let context = appContext
           
           let fetchRequest = NSFetchRequest<Achievement>(entityName: tableName)
           fetchRequest.predicate = NSPredicate(format: "name = %@", name)
           
           do{
               
               try achievements = context.fetch(fetchRequest)
               
           } catch let error as NSError{
               
               print("Errore in fetch \(error.code)")
               
           }
           
           return achievements
           
       }
    
    public static func fetchLocked(appContext: NSManagedObjectContext) -> [Achievement]{
        var achievements: [Achievement] = []
        
        let context = appContext
        
        let fetchRequest = NSFetchRequest<Achievement>(entityName: tableName)
        fetchRequest.predicate = NSPredicate(format: "unlocked = false")
        
        do{
            
            try achievements = context.fetch(fetchRequest)
            
        } catch let error as NSError{
            
            print("Errore in fetch \(error.code)")
            
        }
        
        return achievements
        
    }
    
    public static func fetchUnlocked(appContext: NSManagedObjectContext) -> [Achievement]{
        var achievements: [Achievement] = []
        
        let context = appContext
        
        let fetchRequest = NSFetchRequest<Achievement>(entityName: tableName)
        fetchRequest.predicate = NSPredicate(format: "unlocked = true")
        
        do{
            
            try achievements = context.fetch(fetchRequest)
            
        } catch let error as NSError{
            
            print("Errore in fetch \(error.code)")
            
        }
        
        return achievements
        
    }
    
    
    
    public static func saveContext(appContext: NSManagedObjectContext) {
        let context = appContext
        
        do{
            
            try context.save()
            
        }catch let error as NSError{
            
            print("Errore in fetch \(error.code)")
            
        }
    }
    
    
    public static func deleteAchievement(achievement: Achievement, appContext: NSManagedObjectContext){
        let context = appContext
        context.delete(achievement)
        
        
    }
    
    
//    ADD TASK
}
