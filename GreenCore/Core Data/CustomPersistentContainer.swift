//
//  CustomPersistentContainer.swift
//  GreenCore
//
//  Created by Alessandro De Stefano on 06/06/2020.
//  Copyright © 2020 Alessandro De Stefano. All rights reserved.
//

import Foundation

import UIKit
import CoreData

class NSCustomPersistentContainer: NSPersistentContainer {
    
    override open class func defaultDirectoryURL() -> URL {
        var storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.alessandrodestefano.Greenist")
        storeURL = storeURL?.appendingPathComponent("alessandrodestefano.Greenist.sqlite")
        return storeURL!
    }
    
}
