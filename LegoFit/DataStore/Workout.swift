//
//  ExercisesFromDataBase.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import Foundation
import SwiftData

@Model
final class Workout {
    var name: String
    let date = Date()
    @Relationship(deleteRule: .cascade) var exercises: [Exercise]
    
    init(name: String, exercises: [Exercise]) {
        self.name = name
        self.exercises = exercises
    }
    
    convenience init(item: WorkoutDTO) {
        self.init(
            name: item.name,
            exercises: item.exercises.map { Exercise(item: $0) }
        )
    }
    
    static func getWorkout() -> Workout {
        Workout(name: "First", exercises: Exercise.getExercises())
    }
    
    static func getWorkouts() -> [Workout] {
        [
            Workout(name: "First", exercises: Exercise.getExercises()),
            Workout(name: "Second", exercises: Exercise.getExercises()),
            Workout(name: "Third", exercises: Exercise.getExercises())
        ]
    }
}
