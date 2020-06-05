//
//  OrderArray.swift
//  Homer
//
//  Created by Marco Della Rocca on 18/02/2020.
//  Copyright © 2020 Lorenzo Fasolino. All rights reserved.
//

import Foundation

// MARK: FUNCTIONANT PIECES

class OrderArray {
    static func randomPriorityPoll(maxPriority: Int32, weights: [Int], array: [Task]) -> Int {
        let totWeights = weights.reduce(0,+)
        var polledWeight = Int.random(in: 0 ... Int(totWeights))
        for (i, weight) in weights.enumerated() {
            if polledWeight > weight {
                polledWeight -= weight
            } else {
                return i
            }
        }
        return array.count - 1
    }

    // MARK: MAINFUNCTION

    static func orderWithRandomPriorityPoll(_ array: [Task]) -> [Task] {
        var tasks = array
        var orderedArray: [Task] = []

        let maxPriority = tasks.reduce(-5) {
            count, task in
            task.priority > count ? task.priority : count
        }

        var weights: [Int] = array.map {
            task in
            Int((1000 * pow(Constants.PRIORITY_CONSTANT, Double(maxPriority - task.priority))).rounded())
        }

        var polledIndex: Int
        while !tasks.isEmpty {
            polledIndex = OrderArray.randomPriorityPoll(maxPriority: maxPriority, weights: weights, array: tasks)
            weights.remove(at: polledIndex)
            orderedArray.append(tasks.remove(at: polledIndex))
        }

        return orderedArray
    }

    static func orderWithArrayOfId(arrayOfId: [Int32], arrayOfTasks: [Task]) -> [Task]? {
        var tasks = arrayOfTasks
        var orderedArray: [Task] = []
        for id in arrayOfId {
            if let index = tasks.firstIndex(where: { $0.id == id }) {
                orderedArray.append(tasks.remove(at: index))
            } else {
                return nil
            }
        }
        return orderedArray
    }
}
