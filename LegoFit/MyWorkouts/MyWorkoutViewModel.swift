//
//  MyWorkoutViewViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import Observation

@Observable
final class MyWorkoutViewModel {
    var isWorkoutStart = false
    var sheetPresented: Exercise?
    
    var isAlertPresented = false
    var alertMessage: String?
    
    var sortedExercise: [Exercise] {
        workout.exercises.sorted { $0.queue < $1.queue}
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
    
    private func isExercisesValid() -> Bool {
        var isValid = true
        for exercise in sortedExercise {
            if exercise.set <= 0 || exercise.rep <= 0 {
                isValid.toggle()
                break
            }
        }
        return isValid
    }
}
