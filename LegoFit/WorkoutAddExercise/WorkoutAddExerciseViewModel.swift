//
//  WorkoutEditViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 3/8/24.
//

import Foundation
import Observation

@Observable
final class WorkoutAddExerciseViewModel: FetchedListLapBarViewable {
    var lapQuantity = ""
    var exercisesInLaps: [Exercise] = []
    
    var sheetExercise: Exercise?
    var isAddingLap = false
    
    var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
}
