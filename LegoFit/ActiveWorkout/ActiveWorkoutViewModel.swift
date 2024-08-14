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
    
    private var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    func didFinishApproach(in exercise: ExerciseType) {
        switch exercise {
        case .single(let single):
            if completedApproach == single.rep {
                queue += 1
                completedApproach = 0
            } else {
                completedApproach += 1
            }
            
        case .lap(let lap):
            if completedApproach == lap.quantity {
                queue += 1
                completedApproach = 0
            } else {
                completedApproach += 1
            }
        }
    }
}
