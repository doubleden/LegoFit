//
//  FetchedListDetailsViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 4/8/24.
//

import Foundation
import Observation

@Observable
final class FetchedListDetailsViewModel {
    var approachInputExercise = ""
    var repInputExercise = ""
    var weightInputExercise = ""
    var commentInputExercise = ""
    
    func clearExerciseInputs() {
        approachInputExercise = ""
        repInputExercise = ""
        weightInputExercise = ""
        commentInputExercise = ""
    }
    
    func makeChangesInExercise(exercise: Exercise?) -> Exercise? {
        guard var exercise = exercise else { return nil }
        exercise.approach = Int(approachInputExercise)
        exercise.rep = Int(repInputExercise)
        exercise.weight = weightInputExercise.isEmpty ? "0" : weightInputExercise
        exercise.comment = commentInputExercise
        return exercise
    }
}
