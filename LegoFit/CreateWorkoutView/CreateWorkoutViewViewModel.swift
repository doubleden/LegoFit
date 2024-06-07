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
    
    var workoutDTO = WorkoutDTO()
    var exercisesDTO: [ExerciseDTO] = []
    var isLoading = true
    
    var errorMessage: String?
    var isShowAlertPresented = false
    
    var sheetExercise: ExerciseDTO?
    
    private let networkManager = NetworkManager.shared
    private let storageManager = StorageManager.shared
        
    func fetchExercises() {
        isLoading = true
        errorMessage = nil
        
        networkManager.fetchExercises(from: API.exercises.url) { [unowned self] result in
            switch result {
            case .success(let exercises):
                self.exercisesDTO = exercises
                isLoading = false
            case .failure(let error):
                exercisesDTO = []
                errorMessage = error.localizedDescription
                isShowAlertPresented.toggle()
            }
        }
    }
    
    func addToWorkout(exerciseDTO: ExerciseDTO) {
        workoutDTO.exercises.append(exerciseDTO)
    }
    
    func saveWorkout(modelContext: ModelContext) {
        //TODO: Сделать валидацию для пустой тренировки
        
        let workout = Workout(item: workoutDTO)
        storageManager.save(workout: workout, context: modelContext)
    }
    
    func cancelCrateWorkout() {
        workoutDTO.name = ""
        workoutDTO.exercises.removeAll()
    }
    
    func showDetailsOf(exercise: ExerciseDTO) {
        sheetExercise = exercise
    }
    
    //TODO: Сделать функцию для добавления сет, реп, веса для упражнений и валидация
    
}
