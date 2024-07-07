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
    
    func updateExercise(exercise: Exercise) {
        if let index = exercises.firstIndex(where: {
            if case .single(let exerciseDB) = $0 {
                return exerciseDB.queue == exercise.queue
            }
            return false
        }) {
            exercises[index] = .single(exercise)
        }
    }
    
    func updateExerciseInLap(lapId: Int, exercise: Exercise) {
        if let lapIndex = exercises.firstIndex(where: {
            if case .lap(let lap) = $0 {
                return lap.queue == lapId
            }
            return false
        }) {
            if case .lap(var lap) = exercises[lapIndex] {
                if let exerciseIndex = lap.exercises.firstIndex(where: { $0.id == exercise.id }) {
                    lap.exercises[exerciseIndex] = exercise
                    exercises[lapIndex] = .lap(lap)
                }
            }
        }
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
