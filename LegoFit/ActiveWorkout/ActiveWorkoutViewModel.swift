//
//  ActiveWorkoutViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import Observation

@Observable
final class ActiveWorkoutViewModel {
    
    var buttonTitle: ButtonTitle = .done
    var completedApproach = 0
    var queue = 0
    
    var isExercisesDidEnd = false
    var buttonDidTapped = false
    
    var workoutComment = ""
    
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
    
    func finishApproach() {
        if completedApproach == currentExercise.approach {
            queue += 1
            completedApproach = 0
        } else {
            completedApproach += 1
        }
    }
    
    func isWorkoutDone() -> Bool {
        isLastExercise && completedApproach == currentExercise.approach
    }
    
    func setButtonTittle() {
        if isLastExercise && completedApproach == currentExercise.approach - 1 {
            buttonTitle = .finish
        } else if completedApproach == currentExercise.approach {
            buttonTitle = .next
        } else {
            buttonTitle = .done
        }
    }
}

enum ButtonTitle: String {
    case done = "Done"
    case next = "Next"
    case finish = "Finish"
}
