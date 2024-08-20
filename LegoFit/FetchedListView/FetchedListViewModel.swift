//
//  FetchedListViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 4/8/24.
//

import Observation

@Observable
final class FetchedListViewModel {
    var isFetching = true
    
    var errorMessage: String? = nil
    var isAlertPresented = false
    
    var exercisesCategories: [ExerciseCategory] {
        exercisesCategoriesFiltered.isEmpty ?
        exerciseCategoriesAll : exercisesCategoriesFiltered
    }
    
    var exerciseCategoriesAll: [ExerciseCategory] = []
    private var exercisesCategoriesFiltered: [ExerciseCategory] {
        exerciseCategoriesAll.filter { $0.isSelected }
    }
    
    private var exercises: [Exercise] = []
    private let networkManager = NetworkManager.shared
    
    func fetchExercises() async {
        do {
            exercises = try await networkManager.fetchExercise()
            setCategories()
        } catch {
            exercises = []
            errorMessage = error.localizedDescription
            isAlertPresented.toggle()
        }
        isFetching = false
    }
    
    func refreshExercises() async {
        isFetching.toggle()
        do {
            exerciseCategoriesAll = []
            exercises = []
            try await Task.sleep(nanoseconds: 1_000_000_000)
            await fetchExercises()
        } catch {}
    }
    
    func showFiltered(category: ExerciseCategory) {
        for index in exerciseCategoriesAll.indices {
            exerciseCategoriesAll[index].isSelected = false
        }
        
        if let index = exerciseCategoriesAll.firstIndex(where: { $0.id == category.id }) {
            exerciseCategoriesAll[index].isSelected = !category.isSelected
        }
    }
    
    private func setCategories() {
        let categories = Set(exercises.map { $0.category })
        var sortedCategories: [ExerciseCategory] = []
        for category in categories {
            sortedCategories.append(ExerciseCategory(title: category, exercises: exercises))
        }
        exerciseCategoriesAll = sortedCategories.sorted { $0.title < $1.title}
    }
}
