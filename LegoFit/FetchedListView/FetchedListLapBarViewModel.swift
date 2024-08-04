////
////  FetchedListLapBarViewModel.swift
////  LegoFit
////
////  Created by Denis Denisov on 4/8/24.
////
//
//import Foundation
//import Observation
//
//@Observable
//final class FetchedListLapBarViewModel {
//    var lapQuantity = ""
//    var exercisesInLaps: [Exercise] = []
//    private var workout: Workout
//    
//    init(workout: Workout) {
//        self.workout = workout
//    }
//    
//    func clearLapInputs() {
//        lapQuantity = ""
//        exercisesInLaps = []
//    }
//    
//    func isLapValid() -> Bool {
//        !lapQuantity.isEmpty && !exercisesInLaps.isEmpty
//    }
//    func add(exercise: Exercise, isAddingLap: Bool) {
//        if isAddingLap {
//            exercisesInLaps.append(exercise)
//        } else {
//            workout.exercises.append(.single(exercise))
//        }
//    }
//    
//    func addToWorkoutLap() {
//        let lap = Lap(quantity: Int(lapQuantity) ?? 0, exercises: exercisesInLaps)
//        workout.exercises.append(.lap(lap))
//    }
//}
