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
        for exerciseType in exercises {
            switch exerciseType {
            case .single(let single):
                guard (single.approach ?? 0) > 0 && (single.rep ?? 0) > 0 else {
                    alertMessage = localize(
                        russian: "Подход и повторения должны быть больше 0",
                        english: "Sets and reps must be greater than 0"
                    )
                    return false
                }
            case .lap(let lap):
                guard isExercisesValid(inLap: lap) else {
                    alertMessage = localize(
                        russian: "Количество кругов и повторения должны быть больше 0",
                        english: "The number of laps and reps must be greater than 0"
                    )
                    return false
                }
            }
        }
        return true
    }
    
    private func isExercisesValid(inLap: Lap) -> Bool {
        guard inLap.approach > 0 else { return false }
        for exercise in inLap.exercises {
            if (exercise.rep ?? 0) < 1 {
                return false
            }
        }
        return true
    }
}
