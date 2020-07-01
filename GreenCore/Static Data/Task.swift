//
//  Task.swift
//  GreenCore
//
//  Created by Alessandro De Stefano on 01/07/2020.
//  Copyright © 2020 Alessandro De Stefano. All rights reserved.
//

import Foundation

public class StaticTask {
    
    public var description: String
    public var done: Bool
    public var category: String
    
    init(description: String, category: String) {
        self.description = description
        done = false
        self.category = category
    }
    
}
