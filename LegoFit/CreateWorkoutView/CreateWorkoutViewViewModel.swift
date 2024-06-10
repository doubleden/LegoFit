//
//  CreateWorkoutViewViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//
import Foundation
import Observation
import SwiftData

enum FocusedTextField {
    case sets
    case reps
    case weight
}

@Observable
final class CreateWorkoutViewViewModel {
    
    var isLoading = true
    var workoutDTO = WorkoutDTO()
    
    var exercisesDTO: [ExerciseDTO] = []
    var sheetExercise: ExerciseDTO?
    
    var errorMessage: String?
    var isShowAlertPresented = false
    
    var setInputExercise = ""
    var repInputExercise = ""
    var weightInputExercise = ""
    var isFocused: FocusedTextField? = nil
    
    private let networkManager = NetworkManager.shared
    private let storageManager = StorageManager.shared
    
    // MARK: - Main View
    
    func fetchExercises() {
        DispatchQueue.main.async { [unowned self] in
            isLoading = true
            errorMessage = nil
            
            networkManager.fetchExercises(from: API.exercises.url) { [unowned self] result in
                switch result {
                case .success(let exercises):
                    exercisesDTO = exercises
                    isLoading = false
                case .failure(let error):
                    exercisesDTO = []
                    errorMessage = error.localizedDescription
                    isShowAlertPresented.toggle()
                }
            }
        }
    }
    
    func saveWorkout(modelContext: ModelContext) {
        guard !workoutDTO.exercises.isEmpty,
                !workoutDTO.name.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Workout name or exercise cannot be empty"
            isShowAlertPresented.toggle()
            return
        }
        
        let workout = Workout(item: workoutDTO)
        storageManager.save(workout: workout, context: modelContext)
    }
    
    func cancelCrateWorkout() {
        exercisesDTO = []
        workoutDTO.name = ""
        workoutDTO.exercises.removeAll()
    }
    
    // MARK: - Details View
    
    func showDetailsOf(exercise: ExerciseDTO) {
        sheetExercise = exercise
    }
    
    func addToWorkout(exerciseDTO: ExerciseDTO) {
        
        let exercise = create(exercise: exerciseDTO)
        workoutDTO.exercises.append(exercise)
        
        setInputExercise = ""
        repInputExercise = ""
        weightInputExercise = ""
    }
    
    func changeIsFocused() {
        switch isFocused {
        case .sets:
            isFocused = .reps
        case .reps:
            isFocused = .weight
        default:
            isFocused = nil
        }
    }
    
    private func create(exercise: ExerciseDTO) -> ExerciseDTO {
        ExerciseDTO(
            id: exercise.id,
            category: exercise.category,
            name: exercise.name,
            description: exercise.description,
            image: exercise.image,
            set: Int(setInputExercise) ?? 0,
            rep: Int(repInputExercise) ?? 0,
            weight: Int(weightInputExercise) ?? 0
        )
    }
    
}
