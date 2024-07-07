//
//  Lap.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/7/24.
//

import Foundation

struct Lap: Codable {
    var queue: Int
    var quantity: Int
    var exercises: [Exercise]
    
    static func getLaps() -> [Lap] {
        [
            Lap(queue: 1, quantity: 3, exercises: Exercise.getExercises()),
            Lap(queue: 3, quantity: 2, exercises: Exercise.getExercises()),
            Lap(queue: 5, quantity: 2, exercises: Exercise.getExercises())
        ]
    }
}
