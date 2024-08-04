//
//  FetchedListViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 4/8/24.
//

import Foundation
import Observation

@Observable
final class FetchedListViewModel {
    var errorMessage: String? = nil
    var isAlertPresented = false
    
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
    
    func fetchExercises() {
        Task {
            do {
                exercises = try await networkManager.fetchExercise()
            } catch {
                exercises = []
                errorMessage = error.localizedDescription
                isAlertPresented.toggle()
            }
        }
    }
}
