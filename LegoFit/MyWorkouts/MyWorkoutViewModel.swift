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
    
    var sheetExercise: Exercise?
    var sheetExerciseType: ExerciseType?
    
    var sheetEditLap = false
    
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
    
    func showDetailsView(exercise: Exercise, type: ExerciseType) {
        sheetExercise = exercise
        sheetExerciseType = type
    }
    
    func move(from source: IndexSet, to destination: Int) {
        workout.exercises.move(fromOffsets: source, toOffset: destination)
    }
    
    func moveExercise(in lap: Lap, from source: IndexSet, to destination: Int) {
        guard let lapIndex = workout.exercises.firstIndex(where: {
            if case .lap(let l) = $0 { return l.id == lap.id }
            return false
        }) else { return }
        
        var updatedLap = lap
        updatedLap.exercises.move(fromOffsets: source, toOffset: destination)
        workout.exercises[lapIndex] = .lap(updatedLap)
    }
    
    func deleteExerciseType(_ indexSet: IndexSet) {
        for index in indexSet {
            workout.exercises.remove(at: index)
        }
    }
    
    func delete(in lap: Lap, exerciseWith indexSet: IndexSet) {
        for i in 0..<workout.exercises.count {
            if case var .lap(currentLap) = workout.exercises[i], currentLap == lap {
                for index in indexSet {
                    currentLap.exercises.remove(at: index)
                    workout.exercises[i] = .lap(currentLap)
                    break
                }
            }
        }
    }
    
    func delete(lap: Lap) {
        if lap.exercises.isEmpty {
            for index in 0..<workout.exercises.count {
                if case let .lap(currentLap) = workout.exercises[index] {
                    if currentLap.id == lap.id {
                        workout.exercises.remove(at: index)
                        break
                    }
                }
            }
        }
    }
    
    private func isExercisesValid() -> Bool {
        var isValid = true
        for exercise in exercises {
            switch exercise {
            case .single(let exercise):
                if (exercise.approach ?? 0) <= 0 || (exercise.rep ?? 0) <= 0 {
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
