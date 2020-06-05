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

public class PMDoneTask{
    
    static let tableName = "DoneTask"
    
    @discardableResult
    public static func newDoneTask(task: Task, appContext: NSManagedObjectContext) -> DoneTask{
        let context = appContext
        
        let doneTask = NSEntityDescription.insertNewObject(forEntityName: tableName, into: context) as! DoneTask
        
        doneTask.doneDate = Date()
        doneTask.task = task
        return doneTask
    }
    
    public static func fetchAllDoneTask(appContext: NSManagedObjectContext) -> [DoneTask]{
        var doneTasks: [DoneTask] = []
        
        let context = appContext
        
        let fetchRequest = NSFetchRequest<DoneTask>(entityName: tableName)
        
        do{
            
            try doneTasks = context.fetch(fetchRequest)
            
        } catch let error as NSError{
            
            print("Errore in fetch \(error.code)")
            
        }
        
        return doneTasks
        
    }
    
    public static func fetchByTodayAndTask(task: Task, appContext: NSManagedObjectContext) -> [DoneTask]{
        
        
        
        var doneTasks: [DoneTask] = []
               
               let context = appContext
        
                let todayDate = Date()
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd"
                let day = dateFormatter.string(from: todayDate)
                dateFormatter.dateFormat = "yyyy"
                let year = dateFormatter.string(from: todayDate)
                dateFormatter.dateFormat = "MM"
                let month = dateFormatter.string(from: todayDate)
        
                dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
                let startDate = dateFormatter.date(from: "\(year)/\(month)/\(day) 00:00")
               
               let fetchRequest = NSFetchRequest<DoneTask>(entityName: tableName)
        fetchRequest.predicate = NSPredicate(format: "doneDate >= %@ AND doneDate < %@ AND task = %@", startDate! as NSDate,todayDate as NSDate,task)
               
               do{
                   
                   try doneTasks = context.fetch(fetchRequest)
                   
               } catch let error as NSError{
                   
                   print("Errore in fetch \(error.code)")
                   
               }
               
               return doneTasks
        
        
    }
    
    public static func fetchWeeklyTask(task: Task, appContext: NSManagedObjectContext) -> [DoneTask]{
           
           var doneTasks: [DoneTask] = []
                  
                  let context = appContext
           
                   let todayDate = Date()
        
            var weekday = Calendar.current.component(.weekday, from: todayDate)
            weekday -= 1
            if(weekday == 0 ){
                weekday = 7
            }
        
        
            var endDate = Calendar.current.date(byAdding: .day, value: 7-weekday, to: Date())
            endDate =  Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: endDate!)
        
            let dayToSub = -1*(weekday-1)
        
            var startDate = Calendar.current.date(byAdding: .day, value: dayToSub, to: Date())
             startDate =  Calendar.current.date(bySettingHour: 01, minute: 00, second: 01, of: startDate!)
//
//        print("startDate:\(startDate), endDate:\(endDate), today:\(todayDate)")
        
        
                  let fetchRequest = NSFetchRequest<DoneTask>(entityName: tableName)
           fetchRequest.predicate = NSPredicate(format: "doneDate >= %@ AND doneDate <= %@ AND task = %@", startDate! as NSDate,endDate! as NSDate,task)
                  
                  do{
                      
                      try doneTasks = context.fetch(fetchRequest)
                    
//                    print(doneTasks.count)
                      
                  } catch let error as NSError{
                      
                      print("Errore in fetch \(error.code)")
                      
                  }
                  
                  return doneTasks
           
           
       }
    
    public static func fetchDoneTaskOfDay(appContext: NSManagedObjectContext) -> [DoneTask]{
               
                var doneTasks: [DoneTask] = []
                             
                             let context = appContext
                      
                              let todayDate = Date()
                              
                              let dateFormatter = DateFormatter()
                              dateFormatter.dateFormat = "dd"
                              let day = dateFormatter.string(from: todayDate)
                              dateFormatter.dateFormat = "yyyy"
                              let year = dateFormatter.string(from: todayDate)
                              dateFormatter.dateFormat = "MM"
                              let month = dateFormatter.string(from: todayDate)
                      
                              dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
                              let startDate = dateFormatter.date(from: "\(year)/\(month)/\(day) 00:00")
                             
                             let fetchRequest = NSFetchRequest<DoneTask>(entityName: tableName)
                      fetchRequest.predicate = NSPredicate(format: "doneDate >= %@ AND doneDate < %@ ", startDate! as NSDate,todayDate as NSDate)
                             
                             do{
                                 
                                 try doneTasks = context.fetch(fetchRequest)
                                 
                             } catch let error as NSError{
                                 
                                 print("Errore in fetch \(error.code)")
                                 
                             }
                             
                             return doneTasks
               
               
           }
    
    
    public static func fetchDoneTaskOfMonth(appContext: NSManagedObjectContext) -> [DoneTask]{
        
         var doneTasks: [DoneTask] = []
                      
                      let context = appContext
               
                       let todayDate = Date()
                       
                       let dateFormatter = DateFormatter()
                       dateFormatter.dateFormat = "yyyy"
                       let year = dateFormatter.string(from: todayDate)
                       dateFormatter.dateFormat = "MM"
                       let month = dateFormatter.string(from: todayDate)
               
                       dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
                       let startDate = dateFormatter.date(from: "\(year)/\(month)/01 00:00")
                      
                      let fetchRequest = NSFetchRequest<DoneTask>(entityName: tableName)
               fetchRequest.predicate = NSPredicate(format: "doneDate >= %@ AND doneDate < %@ ", startDate! as NSDate,todayDate as NSDate)
                      
                      do{
                          
                          try doneTasks = context.fetch(fetchRequest)
                          
                      } catch let error as NSError{
                          
                          print("Errore in fetch \(error.code)")
                          
                      }
                      
                      return doneTasks
        
        
    }
    
    public static func fetchDoneTaskOfPreviousDay(task: Task, appContext: NSManagedObjectContext) -> [DoneTask]{
        
         var doneTasks: [DoneTask] = []
                      
                       let context = appContext
               
                       let previuosDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
                       
                       let dateFormatter = DateFormatter()
                       dateFormatter.dateFormat = "dd"
                       let day = dateFormatter.string(from: previuosDate!)
                       dateFormatter.dateFormat = "yyyy"
                       let year = dateFormatter.string(from: previuosDate!)
                       dateFormatter.dateFormat = "MM"
                       let month = dateFormatter.string(from: previuosDate!)
               
                       dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
                       let startDate = dateFormatter.date(from: "\(year)/\(month)/\(day) 00:00")
                        let endDate = dateFormatter.date(from: "\(year)/\(month)/\(day) 23:59")
                      
                      let fetchRequest = NSFetchRequest<DoneTask>(entityName: tableName)
                      fetchRequest.predicate = NSPredicate(format: "doneDate >= %@ AND doneDate <= %@ AND task = %@", startDate! as NSDate,endDate! as NSDate,task)
                      
                      do{
                          
                          try doneTasks = context.fetch(fetchRequest)
                          
                      } catch let error as NSError{
                          
                          print("Errore in fetch \(error.code)")
                          
                      }
                      
                      return doneTasks
        
        
    }
    
    public static func fetchDoneTaskOfPreviousWeek(task: Task, appContext: NSManagedObjectContext) -> [DoneTask]{
           
            var doneTasks: [DoneTask] = []
                         
                          let context = appContext
                  
                          let previuosDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        
                        var weekday = Calendar.current.component(.weekday, from: previuosDate!)
                        weekday -= 1
                        if(weekday == 0 ){
                            weekday = 7
                        }
        
                        var endDate = Calendar.current.date(byAdding: .day, value: 7-weekday, to: previuosDate!)
                        endDate =  Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: endDate!)
                          
                        let dayToSub = -1*(weekday-1)
                              
                        var startDate = Calendar.current.date(byAdding: .day, value: dayToSub, to: previuosDate!)
                         startDate =  Calendar.current.date(bySettingHour: 01, minute: 00, second: 01, of: startDate!)
                         
                         let fetchRequest = NSFetchRequest<DoneTask>(entityName: tableName)
                         fetchRequest.predicate = NSPredicate(format: "doneDate >= %@ AND doneDate <= %@ AND task = %@", startDate! as NSDate,endDate! as NSDate,task)
                         
                         do{
                             
                             try doneTasks = context.fetch(fetchRequest)
                             
                         } catch let error as NSError{
                             
                             print("Errore in fetch \(error.code)")
                             
                         }
                         
                         return doneTasks
           
           
       }
    
    
    
   /* static func fetchAllDoneTaskOfDay() -> [DoneTask]{
        var doneTasks: [DoneTask] = []
        
        let context = getContext()
        
        let fetchRequest = NSFetchRequest<DoneTask>(entityName: name)
        
        do{
            
            try doneTasks = context.fetch(fetchRequest)
            
        } catch let error as NSError{
            
            print("Errore in fetch \(error.code)")
            
        }
        
        return doneTasks
        
    }*/
    
    public static func saveContext(appContext: NSManagedObjectContext) {
        let context = appContext
        
        do{
            
            try context.save()
            
        }catch let error as NSError{
            
            print("Errore in fetch \(error.code)")
            
        }
    }
    
    
    public static func deleteDoneTask(doneTask: DoneTask, appContext: NSManagedObjectContext){
        let context = appContext
        context.delete(doneTask)
        
        
    }
    
}
