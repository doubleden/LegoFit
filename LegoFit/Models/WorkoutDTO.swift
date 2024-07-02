//
//  WorkoutDTO.swift
//  LegoFit
//
//  Created by Denis Denisov on 28/5/24.
//

import Foundation

struct WorkoutDTO {
    var name: String
    var exercises: [ExerciseDTO]
    
    init(name: String = "", exercises: [ExerciseDTO] = []) {
        self.name = name
        self.exercises = exercises
    }
}
