//
//  Lap.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/7/24.
//

import Foundation

struct Lap: Codable, Equatable {
    var id = UUID()
    var quantity: Int
    var exercises: [Exercise]
}

// MARK: - ДЛЯ Preview
extension Lap {
    static func getLaps() -> [Lap] {
        [
            Lap(quantity: 3, exercises: Exercise.getExercises()),
            Lap(quantity: 2, exercises: Exercise.getExercises()),
            Lap(quantity: 2, exercises: Exercise.getExercises())
        ]
    }
}
