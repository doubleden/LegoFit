//
//  CreateWorkoutViewViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//


import Observation

@Observable
final class CreateWorkoutViewViewModel {
    
    var exercises: [ExerciseFromApi] = []
    var isLoading = true
    
    var errorMessage: String?
    var showAlert = false
    
    private let networkManager = NetworkManager.shared
        
    func fetchExercises() {
        errorMessage = nil
        isLoading = true
        
        networkManager.fetchExercises(from: API.exercises.url) { [unowned self] result in
            switch result {
            case .success(let exercises):
                self.exercises = exercises
                isLoading = false
            case .failure(let error):
                errorMessage = error.localizedDescription
                showAlert.toggle()
            }
        }
    }
}
