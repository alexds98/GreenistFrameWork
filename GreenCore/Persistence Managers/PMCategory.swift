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

public class PMCategory{
    
    static let tableName = "Category"
    
    @discardableResult
    public static func newCategory(imageName: String, name: String, appContext: NSManagedObjectContext) -> Category{
        let context = appContext
        
        let category = NSEntityDescription.insertNewObject(forEntityName: tableName, into: context) as! Category
        
        category.image = imageName
        category.name = name
        category.tasks = NSSet()
        
        return category
    }
    
    public static func fetchAllCategory(appContext: NSManagedObjectContext) -> [Category]{
        var categories: [Category] = []
        
        let context = appContext
        
        let fetchRequest = NSFetchRequest<Category>(entityName: tableName)
        
        do{
            
            try categories = context.fetch(fetchRequest)
            
        } catch let error as NSError{
            
            print("Errore in fetch \(error.code)")
            
        }
        
        return categories
        
    }
    
    public static func fetchByName(name: String, appContext: NSManagedObjectContext) -> [Category]{
        var categories: [Category] = []
        
        let context = appContext
        
        let pred = NSPredicate(format: "name = %@", name)
        
        let fetchRequest = NSFetchRequest<Category>(entityName: tableName)
        
        fetchRequest.predicate = pred
        
        do{
            
            
            try categories = context.fetch(fetchRequest)
            
        } catch let error as NSError{
            
            print("Errore in fetch \(error.code)")
            
        }
        
        return categories
        
    }
    
    
    public static func saveContext(appContext: NSManagedObjectContext) {
        let context = appContext
        
        do{
            
            try context.save()
            
        }catch let error as NSError{
            
            print("Errore in fetch \(error.code)")
            
        }
    }
    
    
    
    public static func deleteCategory(category: Category, appContext: NSManagedObjectContext){
        let context = appContext
        context.delete(category)
        
        
    }
    
    
//    ADD TASK
}
