//
//  MyWorkoutDetailsViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import Foundation
import Observation

@Observable
final class MyWorkoutDetailsViewModel {
    var set = ""
    var rep = ""
    var weight = ""
    var comment = ""
    
    var isLap: Bool {
        switch exerciseType {
        case .single(_): false
        case .lap(_): true
        }
    }
    
    private var exercise: Exercise
    private let exerciseType: ExerciseType
    private let workout: Workout
    
    private let storageManager = StorageManager.shared
    
    init(exercise: Exercise, exerciseType: ExerciseType, workout: Workout) {
        self.exercise = exercise
        self.exerciseType = exerciseType
        self.workout = workout
    }
    
    func setupTextFields() {
        set = (exercise.approach ?? 0).formatted()
        rep = (exercise.rep ?? 0).formatted()
        weight = (exercise.weight ?? 0).formatted()
        comment = exercise.comment ?? ""
    }
    
    func saveСhanges() {
        changeParametersInExercise()
        
        switch exerciseType {
        case .single(_):
            storageManager.update(exercise: self.exercise, in: workout)
        case .lap(let lap):
            storageManager.update(
                exercise: exercise,
                withLapQueue: lap.queue,
                in: workout
            )
        }
    }
    
    private func changeParametersInExercise() {
        // Сделать корректное обновление
        exercise.approach = Int(set) ?? 0
        exercise.rep = Int(rep) ?? 0
        exercise.weight = Int(weight) ?? 0
        exercise.comment = comment
    }
}
