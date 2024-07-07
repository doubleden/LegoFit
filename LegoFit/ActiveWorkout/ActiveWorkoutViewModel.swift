////
////  ActiveWorkoutViewModel.swift
////  LegoFit
////
////  Created by Denis Denisov on 27/6/24.
////
//
//import Observation
//
//@Observable
//final class ActiveWorkoutViewModel {
//    
//    var completedSets = 0
//    
//    var buttonText: String {
//        if isLastExercise
//            && completedSets == (exercise.set ?? 0) - 1 {
//            return "Закончить"
//        } else if completedSets == exercise.set {
//            return "Далее"
//        } else {
//            return "Закончил подход"
//        }
//    }
//    
//    var exercise: Exercise {
//        exercises[queue]
//    }
//    
//    var isLastExercise: Bool {
//        exercises.count - 1 == queue
//    }
//    
//    private var queue = 0
//    private let workout: Workout
//    private var exercises: [Exercise] {
//        workout.exercises.sorted { $0.queue ?? 0 < $1.queue ?? 1 }
//    }
//    
//    init(workout: Workout) {
//        self.workout = workout
//    }
//    
//    func showNextExercise() {
//        if completedSets == exercise.set {
//            queue += 1
//            completedSets = 0
//        } else {
//            completedSets += 1
//        }
//    }
//    
//    func finishWorkout(completion: (() -> Void)?) {
//        if isLastExercise && completedSets == exercise.set {
//            completion?()
//            queue = 0
//            completedSets = 0
//        }
//    }
//}
