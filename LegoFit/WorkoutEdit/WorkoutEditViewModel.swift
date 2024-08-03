//
//  WorkoutEditViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 3/8/24.
//

import Foundation
import Observation

@Observable
final class WorkoutEditViewModel: FetchedListWithLapViewable {
    var lapQuantity = ""
    var exercisesInLaps: [Exercise] = []
    
    var sheetExercise: Exercise?
    var isAddingLap = false
    
    var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    func add(exercise: Exercise) {
        var mutableExercise = exercise
        if mutableExercise.weight == nil {
            mutableExercise.weight = "0"
        }
        
        if isAddingLap {
            exercisesInLaps.append(mutableExercise)
        } else {
            workout.exercises.append(.single(mutableExercise))
        }
    }
    
    func addToWorkoutLap() {
        let lap = Lap(quantity: Int(lapQuantity) ?? 0, exercises: exercisesInLaps)
        workout.exercises.append(.lap(lap))
    }
    
}
