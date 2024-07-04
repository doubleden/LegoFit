//
//  MyWorkoutViewViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import Observation
import Foundation

enum ExerciseType: Identifiable {
    case exercise(Exercise)
    case lap(Lap)
    
    var id: Int {
        switch self {
        case .exercise(let exercise):
            exercise.queue
        case .lap(let lap):
            lap.queue
        }
    }
}

@Observable
final class MyWorkoutViewModel {
    var isWorkoutStart = false
    var sheetExerciseDetails: Exercise?
    
    var isAlertPresented = false
    var alertMessage: String?
    
    var exercises: [ExerciseType] = []
    
    let workout: Workout
    
    private var sortedExercises: [Exercise] {
        workout.exercises.sorted { $0.queue < $1.queue}
    }
    
    private var sortedLaps: [Lap] {
        workout.laps.sorted { $0.queue < $1.queue}
    }
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    func getExerciseOrLap() {
        let exerciseQuantity = sortedLaps.count + sortedExercises.count
        var counter = 0
        var queue = 0
        
        while counter < exerciseQuantity {
            for exercise in sortedExercises {
                if queue == exercise.queue {
                    exercises.append(.exercise(exercise))
                    queue += 1
                    counter += 1
                }
            }
            
            for lap in sortedLaps {
                if queue == lap.queue {
                    exercises.append(.lap(lap))
                    queue += 1
                    counter += 1
                }
            }
        }
    }
    
    func startWorkout() {
        guard isExercisesValid() else {
            isAlertPresented.toggle()
            alertMessage = "Проверьте заполнение параметров всех упражнений.\nПодход и повторения должны быть больше 0"
            return
        }
        
        isWorkoutStart.toggle()
    }
    
    func showDetailsView(of exercise: Exercise) {
        sheetExerciseDetails = exercise
    }
    
    private func isExercisesValid() -> Bool {
        var isValid = true
        for exercise in sortedExercises {
            if exercise.set <= 0 || exercise.rep <= 0 {
                isValid.toggle()
                break
            }
        }
        return isValid
    }
}
