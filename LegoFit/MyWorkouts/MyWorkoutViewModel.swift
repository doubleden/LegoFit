//
//  MyWorkoutViewViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import Observation

@Observable
final class MyWorkoutViewModel {
    var sheetPresented: Exercise?
    
    var sortedExercise: [Exercise] {
        workout.exercises.sorted { $0.queue < $1.queue}
    }
    
    private let workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
}
