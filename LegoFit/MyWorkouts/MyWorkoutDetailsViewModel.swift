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
    
    private var exercise: Exercise
    
    init(exercise: Exercise) {
        self.exercise = exercise
    }
    
    func setupTextFields() {
        set = exercise.set.formatted()
        rep = exercise.rep.formatted()
        weight = exercise.weight.formatted()
        comment = exercise.comment
    }
    
    func saveСhanges() {
        exercise.set = Int(set) ?? 0
        exercise.rep = Int(rep) ?? 0
        exercise.weight = Int(weight) ?? 0
        exercise.comment = comment
    }
}
