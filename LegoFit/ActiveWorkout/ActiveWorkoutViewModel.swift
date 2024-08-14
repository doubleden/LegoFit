//
//  ActiveWorkoutViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import Observation

@Observable
final class ActiveWorkoutViewModel {
    var currentExercise: ExerciseType {
        workout.exercises[queue + 1]
    }
    
    var doneApproach = 0
    var queue = 0
    private var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
}
