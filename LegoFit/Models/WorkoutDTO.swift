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

struct ExerciseDTO: Decodable, Identifiable {
    var id: UUID
    let category: String
    let name: String
    let description: String
    let image: String
    
    var set: Int?
    var rep: Int?
    var weight: Int?
    
    static func getExercise() -> ExerciseDTO {
        ExerciseDTO(id: UUID(), category: "legs", name: "Жим ног", description: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", image: "http://127.0.0.1:8080/images/leg_press.png", set: 0, rep: 0, weight: 0)
    }
}
