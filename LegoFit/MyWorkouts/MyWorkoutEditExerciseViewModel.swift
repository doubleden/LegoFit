//
//  MyWorkoutDetailsViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import Foundation
import Observation

@Observable
final class MyWorkoutEditExerciseViewModel {
    var approach = "" {
        didSet {
            exercise.approach = Int(approach) ?? 0
        }
    }
    var rep = "" {
        didSet {
            exercise.rep = Int(rep) ?? 0
        }
    }
    var weight = "" {
        didSet {
            exercise.weight = weight
        }
    }
    var comment = "" {
        didSet {
            exercise.comment = comment
        }
    }
    
    var isLap: Bool {
        switch exerciseType {
        case .single(_): false
        case .lap(_): true
        }
    }
    
    var exercise: Exercise
    
    private let exerciseType: ExerciseType
    private let workout: Workout
    
    private let storageManager = StorageManager.shared
    
    init(exercise: Exercise, exerciseType: ExerciseType, workout: Workout) {
        self.exercise = exercise
        self.exerciseType = exerciseType
        self.workout = workout
    }
    
    func setupTextFields() {
        approach = (exercise.approach ?? 0).formatted()
        rep = (exercise.rep ?? 0).formatted()
        weight = (exercise.weight ?? "0")
        comment = exercise.comment ?? ""
    }
    
    func saveСhanges() {
        switch exerciseType {
        case .single(_):
            storageManager.update(exercise: self.exercise, in: workout)
        case .lap(let lap):
            storageManager.update(
                exercise: exercise,
                withLapID: lap.id,
                in: workout
            )
        }
    }
}
