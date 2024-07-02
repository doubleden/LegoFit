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
    @Relationship(deleteRule: .cascade) var laps: [Lap]
    
    init(name: String, exercises: [Exercise], laps:[Lap]) {
        self.name = name
        self.exercises = exercises
        self.laps = laps
    }
    
    convenience init(item: WorkoutDTO) {
        self.init(
            name: item.name,
            exercises: item.exercises.map { Exercise(item: $0) },
            laps: item.laps.map {Lap(item: $0)}
        )
    }
    
    static func getWorkout() -> Workout {
        Workout(name: "First", exercises: Exercise.getExercises(), laps: Lap.getLaps())
    }
    
    static func getWorkouts() -> [Workout] {
        [
            Workout(name: "First", exercises: Exercise.getExercises(), laps: Lap.getLaps()),
            Workout(name: "Second", exercises: Exercise.getExercises(), laps: Lap.getLaps()),
            Workout(name: "Third", exercises: Exercise.getExercises(), laps: Lap.getLaps())
        ]
    }
}
