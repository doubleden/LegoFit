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
    case lap(LapOfExercises)
    
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
    
    var exercises: [ExerciseType] {
        var combinedList: [(queue: Int, type: ExerciseType)] = []
        var result: [ExerciseType] = []
        
        combinedList.append(contentsOf: sortedExercises.map { (queue: $0.queue, type: .exercise($0)) })
        combinedList.append(contentsOf: sortedLaps.map { (queue: $0.queue, type: .lap($0)) })
        
        combinedList.sort(by: { $0.queue < $1.queue })
        
        for item in combinedList {
            result.append(item.type)
        }
        print("exercises did update")
        
        return result
    }
    
    let workout: Workout
    
    private var sortedExercises: [Exercise] {
        workout.exercises.sorted { $0.queue < $1.queue}
    }
    
    private var sortedLaps: [LapOfExercises] {
        workout.laps.sorted { $0.queue < $1.queue}
    }
    
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
