//
//  ActiveWorkoutViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import Observation

@Observable
final class ActiveWorkoutViewModel {
    
    var buttonTitle = "Done Set"
    var completedApproach = 0
    var queue = 0
    
    var isExercisesCompleted = false
    
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
    
    func didFinish() {
        if completedApproach == currentExercise.approach {
            queue += 1
            completedApproach = 0
        } else {
            completedApproach += 1
        }
    }
    
    func doneWorkout() {
        if isLastExercise && completedApproach == currentExercise.approach {
            isExercisesCompleted.toggle()
        }
    }
    
    func setButtonTittle() {
        // последние упражнение и предпоследний подход
        if isLastExercise && completedApproach == currentExercise.approach - 1 {
            buttonTitle = "Finish"
            // просто предпоследний подход
        } else if completedApproach == currentExercise.approach {
            buttonTitle = "Next"
            // закончить подход
        } else {
            buttonTitle = "Done Set"
        }
    }
}
