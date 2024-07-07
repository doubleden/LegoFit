//
//  MyWorkoutViewViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import Observation
import Foundation

@Observable
final class MyWorkoutViewModel {
    var isWorkoutStart = false
    var sheetExerciseDetails: Exercise?
    var sheetExerciseType: ExerciseType?
    var sheetExerciseQueue: Int?
    var sheetExerciseInLapQueue: Int?
    
    var isAlertPresented = false
    var alertMessage: String?
    
    var exercises: [ExerciseType] {
        workout.exercises
    }
    
    let workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    func startWorkout() {
        guard isExercisesValid() else {
            isAlertPresented.toggle()
            alertMessage = "Проверьте заполнение параметров всех упражнений.\nПодход и повторения должны быть больше 0"
            return
        }
        
        isWorkoutStart.toggle()
    }
    
    func showDetailsView(exercise: Exercise, type: ExerciseType, queue: Int , queueForLap: Int = 0) {
        sheetExerciseDetails = exercise
        sheetExerciseType = type
        sheetExerciseQueue = queue
        sheetExerciseInLapQueue = queueForLap
    }
    
    private func isExercisesValid() -> Bool {
        var isValid = true
        for exercise in exercises {
            switch exercise {
            case .single(let exercise):
                if (exercise.set ?? 0) <= 0 || (exercise.rep ?? 0) <= 0 {
                    isValid.toggle()
                    break
                }
            case .lap(let lap):
                if lap.quantity <= 0 {
                    isValid.toggle()
                    break
                }
            }
        }
        return isValid
    }
}
