//
//  ExercisesFromDataBase.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import Foundation
import SwiftData

enum ExerciseType: Codable, Identifiable {
    case single(Exercise)
    case lap(Lap)
    
    var id: Int {
        switch self {
        case .single(let exercise):
            exercise.queue ?? 0
        case .lap(let lap):
            lap.queue
        }
    }
}

@Model
final class Workout {
    var name: String
    let date = Date()
    var isDone = false
    var exercises: [ExerciseType]
    
    init(name: String = "", exercises: [ExerciseType] = []) {
        self.name = name
        self.exercises = exercises
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
