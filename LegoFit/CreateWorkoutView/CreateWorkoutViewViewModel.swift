//
//  CreateWorkoutViewViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import Foundation
import Observation
import Alamofire

@Observable
final class CreateWorkoutViewViewModel {
    
    var exercises: [ExerciseFromApi] = []
    var isLoading: Bool = false
    var errorMessage: String?
        
    func fetchExercises() {
        isLoading = true
        errorMessage = nil
        
        AF.request(API.exercises.url)
            .validate()
            .responseDecodable(of: [ExerciseFromApi].self) { response in
            self.isLoading = false
            switch response.result {
            case .success(let exercises):
                self.exercises = exercises
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
