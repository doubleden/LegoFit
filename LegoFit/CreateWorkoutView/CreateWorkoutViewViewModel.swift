//
//  CreateWorkoutViewViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//


import Observation
import SwiftUI
import SwiftData

@Observable
final class CreateWorkoutViewViewModel {
    
    var exercises: [ExerciseFromApi] = []
    var isLoading = true
    
    var errorMessage: String?
    var errorShowAlert = false
    
    private let networkManager = NetworkManager.shared
    private let storageManager = StorageManager.shared
        
    func fetchExercises() {
        isLoading = true
        errorMessage = nil
        
        networkManager.fetchExercises(from: API.exercises.url) { [unowned self] result in
            switch result {
            case .success(let exercises):
                self.exercises = exercises
                isLoading = false
            case .failure(let error):
                exercises = []
                errorMessage = error.localizedDescription
                errorShowAlert.toggle()
            }
        }
    }
    
    func addToWorkout(exerciseFromApi: ExerciseFromApi) {
        
    }
    
    func saveWorkout() {
        
    }
}
