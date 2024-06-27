//
//  CreateWorkoutViewViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//
import Observation
import SwiftData

@Observable
final class CreateWorkoutViewViewModel {
    
    var isLoading = true
    var workoutDTO = WorkoutDTO()
    var sheetExercise: ExerciseDTO?
    var isSaveSheetPresented = false
    
    var errorMessage: String? = nil
    var isShowAlertPresented = false
    
    var setInputExercise = ""
    var repInputExercise = ""
    var weightInputExercise = ""
    var commentInputExercise = ""
    var isFocused: FocusedTextField? = nil
    
    var sortedByCategoryExercises: [String: [ExerciseDTO]] {
        [
            "Ноги" : exercisesDTO.filter { $0.category == "legs" },
            "Грудь" : exercisesDTO.filter { $0.category == "chest" },
            "Плечи" : exercisesDTO.filter {$0.category == "shoulders" },
            "Спина" : exercisesDTO.filter { $0.category == "back" },
            "Руки" : exercisesDTO.filter { $0.category == "arms" }
        ]
    }
    
    private var exercisesDTO: [ExerciseDTO] = []
    private let networkManager = NetworkManager.shared
    private let storageManager = StorageManager.shared
    private var queue = 0
    
    // MARK: - Main View
    
    func fetchExercises() {
        Task {
            do {
                exercisesDTO = try await networkManager.fetchExercise()
                isLoading = false
            } catch {
                exercisesDTO = []
                isLoading = false
                errorMessage = error.localizedDescription
                isShowAlertPresented.toggle()
            }
        }
    }
    
    func isWorkoutNameValid() -> Bool {
        !workoutDTO.name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func isExercisesInWorkoutEmpty() -> Bool {
        workoutDTO.exercises.isEmpty
    }
    
    func saveWorkout(modelContext: ModelContext) {
        let workout = Workout(item: workoutDTO)
        storageManager.save(workout: workout, context: modelContext)
    }
    
    func cancelCreateWorkout() {
        queue = 0
        workoutDTO.name = ""
        workoutDTO.exercises.removeAll()
    }
    
    func showSheetOf(exercise: ExerciseDTO) {
        sheetExercise = exercise
    }
    
    func addToWorkout(exerciseDTO: ExerciseDTO) {
        let exercise = create(exercise: exerciseDTO)
        workoutDTO.exercises.append(exercise)
        queue += 1
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
    
    private func create(exercise: ExerciseDTO) -> ExerciseDTO {
        ExerciseDTO(
            id: exercise.id, 
            queue: queue,
            category: exercise.category,
            name: exercise.name,
            description: exercise.description,
            image: exercise.image,
            set: Int(setInputExercise) ?? 0,
            rep: Int(repInputExercise) ?? 0,
            weight: Int(weightInputExercise) ?? 0,
            comment: commentInputExercise
        )
    }
}
