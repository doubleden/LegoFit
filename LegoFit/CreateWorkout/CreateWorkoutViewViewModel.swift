//
//  CreateWorkoutViewViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//
import Observation
import SwiftData

@Observable
final class CreateWorkoutViewModel {
    
    var isLoading = true
    var workout = Workout()
    var sheetExercise: Exercise?
    var isSaveSheetPresented = false
    
    var errorMessage: String? = nil
    var isShowAlertPresented = false
    
    var setInputExercise = ""
    var repInputExercise = ""
    var weightInputExercise = ""
    var commentInputExercise = ""
    var isFocused: FocusedTextField? = nil
    
    var isAddingLaps = false
    var lapInput = ""
    var exercisesInLaps: [Exercise] = []
    
    //временно
    var isAlertForLapsPresented = false
    
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
    private var queue = 0
    
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
                isShowAlertPresented.toggle()
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
    }
    
    func cancelCreateWorkout(modelContext: ModelContext) {
        workout = Workout()
    }
    
    func showSheetOf(exercise: Exercise) {
        sheetExercise = exercise
    }
    
    func addToWorkout( exercise: inout Exercise) {
        exercise.queue = queue
        workout.exercises.append(.single(exercise))
        queue += 1
    }
    
    func addToWorkoutLap() {
        let lap = Lap(queue: queue, quantity: Int(lapInput) ?? 0, exercises: exercisesInLaps)
        workout.exercises.append(.lap(lap))
        queue += 1
        lapInput = ""
    }
    
    func addToLap(exercise: Exercise) {
        exercisesInLaps.append(exercise)
    }
    
    // MARK: - Details View
    
    func clearInputs() {
        setInputExercise = ""
        repInputExercise = ""
        weightInputExercise = ""
        commentInputExercise = ""
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
