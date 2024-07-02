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
    var laps: [LapDTO]
    
    init(
        name: String = "",
        exercises: [ExerciseDTO] = [],
        laps: [LapDTO] = []
    ) {
        self.name = name
        self.exercises = exercises
        self.laps = laps
    }
}
