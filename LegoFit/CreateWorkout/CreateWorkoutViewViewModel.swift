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
final class CreateWorkoutViewModel {
    
    var isLoading = true
    var workout = Workout()
    var isDidSave = false
    var sheetExercise: Exercise?
    var isSaveSheetPresented = false
    
    var errorMessage: String? = nil
    var isAlertPresented = false
    
    var approachInputExercise = ""
    var repInputExercise = ""
    var weightInputExercise = ""
    var commentInputExercise = ""
    var isFocused: FocusedTextField? = nil
    
    var isAddingLap = false
    var lapQuantity = ""
    var exercisesInLaps: [Exercise] = []
    
    var sortedByCategoryExercises: [String: [Exercise]] {
        [
            "Legs" : exercises.filter { $0.category == "legs" },
            "Chest" : exercises.filter { $0.category == "chest" },
            "Shoulders" : exercises.filter {$0.category == "shoulders" },
            "Back" : exercises.filter { $0.category == "back" },
            "Arms" : exercises.filter { $0.category == "arms" }
        ]
    }
    
    private var exercises: [Exercise] = []
    private let networkManager = NetworkManager.shared
    private let storageManager = StorageManager.shared
    
    // MARK: - Main View
    
    func fetchExercises() {
        Task {
            do {
                exercises = try await networkManager.fetchExercise()
                isLoading = false
            } catch {
                exercises = []
                isLoading = false
                errorMessage = error.localizedDescription
                isAlertPresented.toggle()
            }
        }
    }
    
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
    
    func showSheetOf(exercise: Exercise) {
        sheetExercise = exercise
    }
    
    func add(exercise: Exercise) {
        if isAddingLap {
            addToLap(exercise: exercise)
        } else {
            var mutableExercise = exercise
            if mutableExercise.weight == nil {
                mutableExercise.weight = "0"
            }
            addToWorkout(exercise: &mutableExercise)
        }
    }
    
    func addToWorkoutLap() {
        let lap = Lap(quantity: Int(lapQuantity) ?? 0, exercises: exercisesInLaps)
        workout.exercises.append(.lap(lap))
        clearLapInputs()
    }
    
    func clearLapInputs() {
        lapQuantity = ""
        exercisesInLaps = []
    }
    
    func isLapValid() -> Bool {
        !lapQuantity.isEmpty && !exercisesInLaps.isEmpty
    }
    
    private func addToWorkout(exercise: inout Exercise) {
        workout.exercises.append(.single(exercise))
    }
    
    private func addToLap(exercise: Exercise) {
        exercisesInLaps.append(exercise)
    }
    
    // MARK: - Details View
       
   func clearExerciseInputs() {
       approachInputExercise = ""
       repInputExercise = ""
       weightInputExercise = ""
       commentInputExercise = ""
   }
   
   func makeChangesInExercise() -> Exercise? {
       guard var exercise = sheetExercise else { return nil }
       exercise.approach = Int(approachInputExercise)
       exercise.rep = Int(repInputExercise)
       exercise.weight = weightInputExercise
       exercise.comment = commentInputExercise
       return exercise
   }
   
   func changeIsFocused() {
       switch isFocused {
       case .sets:
           isFocused = .reps
       case .reps:
           isFocused = .weight
       case .weight:
           isFocused = .comment
       default:
           isFocused = nil
       }
   }
}
