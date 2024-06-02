//
//  ExercisesFromDataBase.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import Foundation
import SwiftData

@Model
final class Workout {
    let name: String
    @Relationship(deleteRule: .cascade) var exercises: [Exercise]
    
    init(name: String, exercises: [Exercise]) {
        self.name = name
        self.exercises = exercises
    }
    
    convenience init(item: WorkoutDTO) {
        self.init(
            name: item.name,
            exercises: item.exercises.map { Exercise(item: $0) }
        )
    }
}

@Model
final class Exercise {
    let category: String
    let name: String
    let definition: String
    let photo: String
    
    var set: Int
    var rep: Int
    var weight: Int
    
    init(
        category: String,
        name: String,
        definition: String,
        photo: String,
        set: Int = 0,
        rep: Int = 0,
        weight: Int = 0
    ) {
        self.category = category
        self.name = name
        self.definition = definition
        self.photo = photo
        self.set = set
        self.rep = rep
        self.weight = weight
    }
    
    convenience init(item: ExerciseDTO) {
        self.init(
            category: item.category,
            name: item.name,
            definition: item.description,
            photo: item.image
        )
    }
}
