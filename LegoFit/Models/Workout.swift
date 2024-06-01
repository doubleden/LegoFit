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
    
    init(name: String = "", exercises: [Exercise] = []) {
        self.name = name
        self.exercises = exercises
    }
}

@Model
final class Exercise {
    let id: Int
    let category: String
    let name: String
    let definition: String
    let photo: String
    
    var set: Int
    var rep: Int
    var weight: Int
    
    init(
        id: Int,
        category: String,
        name: String,
        definition: String,
        photo: String,
        set: Int = 0,
        rep: Int = 0,
        weight: Int = 0
    ) {
        self.id = id
        self.category = category
        self.name = name
        self.definition = definition
        self.photo = photo
        self.set = set
        self.rep = rep
        self.weight = weight
    }
}
