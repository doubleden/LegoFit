//
//  ExerciseDTO.swift
//  LegoFit
//
//  Created by Denis Denisov on 29/6/24.
//

import Foundation

struct ExerciseDTO: Decodable, Identifiable {
    var id: UUID
    let queue: Int?
    let category: String
    let name: String
    let description: String
    let image: String
    
    let set: Int?
    let rep: Int?
    let weight: Int?
    let comment: String?
    
    static func getExercise() -> ExerciseDTO {
        ExerciseDTO(id: UUID(), queue: 1, category: "legs", name: "Жим ног", description: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", image: "http://127.0.0.1:8080/images/leg_press.png", set: 0, rep: 0, weight: 0, comment: "С резинками")
    }
}
