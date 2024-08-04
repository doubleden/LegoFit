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
final class CreateWorkoutViewModel: FetchedListLapBarViewable {
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
        isAddingLap = false
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
}
