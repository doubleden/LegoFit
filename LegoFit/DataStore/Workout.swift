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
    var isDone = false
    
    @Relationship(deleteRule: .cascade) var exercises: [Exercise]
    @Relationship(deleteRule: .cascade) var laps: [LapOfExercises]
    
    init(name: String, exercises: [Exercise], laps:[LapOfExercises]) {
        self.name = name
        self.exercises = exercises
        self.laps = laps
    }
    
    convenience init(item: WorkoutDTO) {
        self.init(
            name: item.name,
            exercises: item.exercises.map { Exercise(item: $0) },
            laps: item.laps.map {LapOfExercises(item: $0)}
        )
    }
    
    static func getWorkout() -> Workout {
        Workout(name: "First", exercises: Exercise.getExercises(), laps: LapOfExercises.getLaps())
    }
    
    static func getWorkouts() -> [Workout] {
        [
            Workout(name: "First", exercises: Exercise.getExercises(), laps: LapOfExercises.getLaps()),
            Workout(name: "Second", exercises: Exercise.getExercises(), laps: LapOfExercises.getLaps()),
            Workout(name: "Third", exercises: Exercise.getExercises(), laps: LapOfExercises.getLaps())
        ]
    }
}
