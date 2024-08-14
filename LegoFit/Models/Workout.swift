//
//  ExercisesFromDataBase.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import Foundation
import SwiftData

enum ExerciseType: Codable, Identifiable, Equatable {
    case single(Exercise)
    case lap(Lap)
    
    var id: UUID {
        switch self {
        case .single(let exercise):
            exercise.id
        case .lap(let lap):
            lap.id
        }
    }
}

@Model
final class Workout {
    var name: String
    let date = Date()
    var isDone = false
    var exercises: [ExerciseType]
    var comment = ""
    
    init(name: String = "", exercises: [ExerciseType] = []) {
        self.name = name
        self.exercises = exercises
    }
    
    func findIndex(ofLap: Lap) -> Int? {
        guard let lapIndex = self.exercises.firstIndex(where: {
            if case .lap(let lap) = $0 {
                return lap.id == ofLap.id
            }
            return false
        }) else {
            return nil
        }
        
        return lapIndex
    }
}

// MARK: - ДЛЯ Preview
extension Workout {
    static func getWorkout() -> Workout {
        let exercises: [ExerciseType] = [.single(Exercise.getExercises().first!), .lap(Lap.getLaps().first!)]
        return Workout(name: "First", exercises: exercises)
    }
    
    static func getWorkouts() -> [Workout] {
        let exercises: [ExerciseType] = [.single(Exercise.getExercises().first!), .lap(Lap.getLaps().first!)]
        return [
            Workout(name: "First", exercises: exercises),
            Workout(name: "Second", exercises: exercises),
            Workout(name: "Third", exercises: exercises)
        ]
    }
}
