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
    
    func setButtonTittle() {
        if isLastExercise && completedApproach == currentExercise.approach {
            buttonTitle = .finish
        } else if completedApproach == currentExercise.approach {
            buttonTitle = .next
        } else {
            buttonTitle = .done
        }
    }
}

enum ButtonTitle {
    case done
    case next
    case finish
    
    var localized: String {
        switch self {
        case .done:
            return localize(russian: "Сделано", english: "Done")
        case .next:
            return localize(russian: "Далее", english: "Next")
        case .finish:
            return localize(russian: "Завершить", english: "Finish")
        }
    }
}
