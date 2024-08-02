//
//  Lap.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/7/24.
//

import Foundation

struct Lap: Codable, Equatable, Identifiable {
    var id = UUID()
    var quantity: Int
    var exercises: [Exercise]
    
    func findIndex(workout: Workout) -> Int? {
        guard let lapIndex = workout.exercises.firstIndex(where: {
            if case .lap(let currentLap) = $0 { return currentLap.id == self.id }
            return false
        }) else { return nil }
        return lapIndex
    }
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
