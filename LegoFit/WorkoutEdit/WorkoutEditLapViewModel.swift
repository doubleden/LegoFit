//
//  WorkoutEditLapViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import Observation

@Observable
final class WorkoutEditLapViewModel: FetchedListViewable {
    
    var sheetExercise: Exercise?
    var isAddingLap = true
    
    
    private var workout: Workout
    private var lap: Lap
    
    init(workout: Workout, lap: Lap) {
        self.workout = workout
        self.lap = lap
    }
    
    func showSheetOf(exercise: Exercise) {
        sheetExercise = exercise
    }
    
    func add(exercise: Exercise) {
        guard let indexLap = workout.findIndex(ofLap: lap) else { return }
        if case var .lap(changedLap) = workout.exercises[indexLap] {
            changedLap.exercises.append(exercise)
            workout.exercises[indexLap] = .lap(changedLap)
        }
    }
}
