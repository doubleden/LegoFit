//
//  Lap.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/7/24.
//

import Foundation

struct Lap: Codable, Equatable, Identifiable, Hashable {
    var id = UUID()
    var approach: Int
    var exercises: [Exercise]
}

// MARK: - ДЛЯ Preview
extension Lap {
    static func getLaps() -> [Lap] {
        [
            Lap(approach: 3, exercises: Exercise.getExercises()),
            Lap(approach: 2, exercises: Exercise.getExercises()),
            Lap(approach: 2, exercises: Exercise.getExercises())
        ]
    }
}
