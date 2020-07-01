//
//  Category.swift
//  GreenCore
//
//  Created by Alessandro De Stefano on 01/07/2020.
//  Copyright © 2020 Alessandro De Stefano. All rights reserved.
//

import Foundation

public class StaticCategory {
    
    public var name: String
    public var tasks: [StaticTask]
    
    init (name: String, tasks:[StaticTask]) {
        self.name = name
        self.tasks = tasks
    }
    
}
