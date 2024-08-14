//
//  ActiveWorkoutViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import Observation

@Observable
final class ActiveWorkoutViewModel {
    
    var completedApproach = 0
    var queue = 0
    
    var currentExercise: ExerciseType {
        workout.exercises[queue]
    }
    
    var isLastExercise: Bool {
        workout.exercises.count - 1 == queue
    }
    
    var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    func didFinish(approach: Int) {
        if completedApproach == approach {
            queue += 1
            completedApproach = 0
        } else {
            completedApproach += 1
        }
    }
    
    func doneWorkout(_ exerciseApproach: Int) {
        if isLastExercise && completedApproach == exerciseApproach {
            workout.isDone.toggle()
        }
    }
}
