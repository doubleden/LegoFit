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
    
    private let workout: Workout
    private let queue: Int
    private let queueInLap: Int?
    private let exerciseType: ExerciseType
    private let exercise: Exercise
    
    init(workout: Workout, queue: Int, queueInLap: Int = 0, exerciseType: ExerciseType, exercise: Exercise) {
        self.workout = workout
        self.queue = queue
        self.queueInLap = queueInLap
        self.exerciseType = exerciseType
        self.exercise = exercise
    }
    
    func setupTextFields() {
        set = (exercise.set ?? 0).formatted()
        rep = (exercise.rep ?? 0).formatted()
        weight = (exercise.weight ?? 0).formatted()
        comment = exercise.comment ?? ""
    }
    
    func saveСhanges() {
        
//        exercise.set = Int(set) ?? 0
//        exercise.rep = Int(rep) ?? 0
//        exercise.weight = Int(weight) ?? 0
//        exercise.comment = comment
    }
    
    
}
