//
//  Init.swift
//  GreenCore
//
//  Created by Alessandro De Stefano on 01/07/2020.
//  Copyright © 2020 Alessandro De Stefano. All rights reserved.
//

import Foundation

public class StaticInit {
    
    public var categories: [StaticCategory]
    
    public init() {
        
        var tempTask = StaticTask(description: "Turn the tap off when brushing your teeth", category: "acqua")
        var tempTask2 = StaticTask(description: "Use the dishwasher instead of washing by hand", category: "acqua")
        let tempTask3 = StaticTask(description: "Start the dishwasher only when full", category: "acqua")
        let acquaCat = StaticCategory(name: "acqua", tasks: [tempTask, tempTask2, tempTask3])
        
        tempTask = StaticTask(description: "Don't leave your television on without anyone watching", category: "energia")
        tempTask2 = StaticTask(description: "Before using the hairdryer, dry your hair as much as you can with a towel", category: "energia")
        let energiaCat = StaticCategory(name: "energia", tasks: [tempTask, tempTask2])
        
        tempTask = StaticTask(description: "Use (and re-use) a glass bottle instead of a plastic one", category: "spazzatura")
        tempTask2 = StaticTask(description: "Try producing only a bag of mixed waste", category: "spazzatura")
        let spazzaturaCat = StaticCategory(name: "spazzatura", tasks: [tempTask, tempTask2])
        
        tempTask = StaticTask(description: "Use public transport instead of your car", category: "trasporto")
        tempTask2 = StaticTask(description: "Use your car only if all the seats are occupied", category: "trasporto")
        let trasportoCat = StaticCategory(name: "trasporto", tasks: [tempTask, tempTask2])
        
        tempTask = StaticTask(description: "Check your food storage before going to buy groceries", category: "cibo")
        tempTask2 = StaticTask(description: "Go eat out only once this week", category: "cibo")
        let ciboCat = StaticCategory(name: "cibo", tasks: [tempTask, tempTask2])
        
        categories = [acquaCat, energiaCat, spazzaturaCat, trasportoCat, ciboCat]
    }
    
}
