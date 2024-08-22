//
//  MyWorkoutViewViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import Observation
import Foundation

@Observable
final class MyWorkoutViewModel: ExerciseListCellDeletable {
    var activeWorkout: Workout?
    
    var sheetExercise: Exercise?
    var sheetExerciseType: ExerciseType?
    
    var sheetEditLap: Lap?
    
    var isAlertPresented = false
    var alertMessage: String?
    
    var exercises: [ExerciseType] {
        workout.exercises
    }
    
    var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    func startWorkout() {
        guard isExercisesValid() else {
            isAlertPresented.toggle()
            alertMessage = "Проверьте заполнение параметров всех упражнений.\nПодход и повторения должны быть больше 0"
            return
        }
        activeWorkout = workout
    }
    
    func showDetailsView(exercise: Exercise, type: ExerciseType) {
        sheetExercise = exercise
        sheetExerciseType = type
    }
    
    func showEditLapView(lap: Lap) {
        sheetEditLap = lap
    }
    
    func moveCell(from source: IndexSet, to destination: Int) {
        workout.exercises.move(fromOffsets: source, toOffset: destination)
    }
    
    func moveExercise(in lap: Lap, from source: IndexSet, to destination: Int) {
        guard let lapIndex = workout.findIndex(ofLap: lap) else { return }
        var updatedLap = lap
        updatedLap.exercises.move(fromOffsets: source, toOffset: destination)
        workout.exercises[lapIndex] = .lap(updatedLap)
    }
    
    private func isExercisesValid() -> Bool {
        for exercise in exercises {
            switch exercise {
            case .single(let exercise):
                if (exercise.approach ?? 0) < 1 || (exercise.rep ?? 0) < 1 {
                    return false
                }
            case .lap(let lap):
                if lap.approach < 1 {
                    return false
                }
            }
        }
        return true
    }
}
