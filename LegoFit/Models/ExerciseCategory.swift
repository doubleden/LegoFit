//
//  ExerciseCategory.swift
//  LegoFit
//
//  Created by Denis Denisov on 8/8/24.
//

import Foundation

struct ExerciseCategory: Identifiable, Equatable {
    var id = UUID()
    let title: String
    let exercises: [Exercise]
    var isSelected = false
    
    init(title: String, exercises: [Exercise]) {
        self.title = title
        self.exercises = exercises.filter { $0.category == title }
    }
}
