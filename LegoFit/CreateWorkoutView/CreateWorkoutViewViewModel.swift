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
    
    var setInputExercise = ""
    var repInputExercise = ""
    var weightInputExercise = ""
    
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
        //TODO: Валидация на 0 параметры
        let exercise = create(exercise: exerciseDTO)
        workoutDTO.exercises.append(exercise)
        
        setInputExercise = ""
        repInputExercise = ""
        weightInputExercise = ""
    }
    
    func saveWorkout(modelContext: ModelContext) {
        //TODO: Сделать валидацию для пустой тренировки
        guard !workoutDTO.exercises.isEmpty else {
            errorMessage = "Workout cannot be empty"
            isShowAlertPresented.toggle()
            return
        }
        
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
    
    private func create(exercise: ExerciseDTO) -> ExerciseDTO {
        ExerciseDTO(
            id: exercise.id,
            category: exercise.category,
            name: exercise.name,
            description: exercise.description,
            image: exercise.image,
            set: Int(setInputExercise) ?? exercise.set,
            rep: Int(repInputExercise) ?? exercise.rep,
            weight: Int(weightInputExercise) ?? exercise.weight
        )
    }
    
}
