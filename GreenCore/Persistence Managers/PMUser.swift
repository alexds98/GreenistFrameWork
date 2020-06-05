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

public class PMUser{
    
    static let tableName = "User"
    
    @discardableResult
    public static func newUser(appContext: NSManagedObjectContext) -> User{
        let context = appContext
        
        let user = NSEntityDescription.insertNewObject(forEntityName: tableName, into: context) as! User
        
        user.totEcoPoints = 0
        user.totSavings = 0
        
        return user
    }
    
    public static func fetchAllUsers(appContext: NSManagedObjectContext) -> [User]{
        var users: [User] = []
        
        let context = appContext
        
        let fetchRequest = NSFetchRequest<User>(entityName: tableName)
        
        do{
            
            try users = context.fetch(fetchRequest)
            
        } catch let error as NSError{
            
            print("Errore in fetch \(error.code)")
            
        }
        
        return users
        
    }
    
    public static func fetchUser(appContext: NSManagedObjectContext) -> User{
        var users: [User] = []
        
        let context = appContext
        
        let fetchRequest = NSFetchRequest<User>(entityName: tableName)
        
        do{
            
            try users = context.fetch(fetchRequest)
            
        } catch let error as NSError{
            
            print("Errore in fetch \(error.code)")
            
        }
        
        return users[0]
        
    }
  
    
    
    
    public static func saveContext(appContext: NSManagedObjectContext) {
        let context = appContext
        
        do{
            
            try context.save()
            
        }catch let error as NSError{
            
            print("Errore in fetch \(error.code)")
            
        }
    }
    
    
    public static func deleteUser(user: User, appContext: NSManagedObjectContext){
        let context = appContext
        context.delete(user)
        
        
    }
    
}
