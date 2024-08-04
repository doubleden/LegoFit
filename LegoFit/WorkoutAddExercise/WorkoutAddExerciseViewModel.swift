//
//  WorkoutEditViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 3/8/24.
//

import Foundation
import Observation

@Observable
final class WorkoutAddExerciseViewModel: FetchedListLapBarViewable {
    var lapQuantity = ""
    var exercisesInLaps: [Exercise] = []
    
    var sheetExercise: Exercise?
    var isAddingLap = false
    
    var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    func add(exercise: Exercise) {
        if isAddingLap {
            exercisesInLaps.append(exercise)
        } else {
            workout.exercises.append(.single(exercise))
        }
    }
    
    func addToWorkoutLap() {
        let lap = Lap(quantity: Int(lapQuantity) ?? 0, exercises: exercisesInLaps)
        workout.exercises.append(.lap(lap))
    }
    
}
