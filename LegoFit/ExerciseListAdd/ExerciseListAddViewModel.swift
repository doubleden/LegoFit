//
//  ExerciseListAddViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 4/8/24.
//

import Observation

@Observable
final class ExerciseListAddViewModel: FetchedListViewable {
    var workout: Workout
    var sheetExercise: Exercise?
    
    var lapQuantity = ""
    var exercisesInLaps: [Exercise] = []
    var isAddingLap = false
    
    init(workout: Workout = Workout()) {
        self.workout = workout
    }
    
    func add(exercise: Exercise) {
        if isAddingLap {
            exercisesInLaps.append(exercise)
        } else {
            workout.exercises.append(.single(exercise))
        }
    }
    
    func addToWorkoutLap() {
        let lap = Lap(quantity: Int(lapQuantity) ?? 0, exercises: exercisesInLaps)
        workout.exercises.append(.lap(lap))
    }
    
    func clearLapInputs() {
        lapQuantity = ""
        exercisesInLaps = []
    }
    
    func isLapValid() -> Bool {
        !lapQuantity.isEmpty && !exercisesInLaps.isEmpty
    }
}
