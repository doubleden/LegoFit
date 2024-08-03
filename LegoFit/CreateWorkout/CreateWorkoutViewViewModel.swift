//
//  CreateWorkoutViewViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//
import Observation
import SwiftData
import Foundation

@Observable
final class CreateWorkoutViewModel: FetchedListWithLapViewable {
    var workout = Workout()
    var isDidSave = false
    var sheetExercise: Exercise?
    var isSaveSheetPresented = false
    
    var isAddingLap = false
    var lapQuantity = ""
    var exercisesInLaps: [Exercise] = []
    
    private let storageManager = StorageManager.shared
    
    // MARK: - Main View
    
    func isWorkoutNameValid() -> Bool {
        !workout.name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func isExercisesInWorkoutEmpty() -> Bool {
        workout.exercises.isEmpty
    }
    
    func saveWorkout(modelContext: ModelContext) {
        storageManager.save(workout: workout, context: modelContext)
        isDidSave.toggle()
    }
    
    func cancelCreateWorkout(modelContext: ModelContext) {
        workout = Workout()
    }
    
    func deleteExercise(withID: UUID) {
        if let index = workout.exercises.firstIndex(where: {
            switch $0 {
            case .single(let single):
                single.id == withID
            case .lap(let lap):
                lap.id == withID
            }
        }) {
            workout.exercises.remove(at: index)
        }
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
}
