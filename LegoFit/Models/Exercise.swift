//
//  Exercise.swift
//  LegoFit
//
//  Created by Denis Denisov on 29/6/24.
//

import Foundation

struct Exercise: Codable, Identifiable {
    var id: UUID
    var queue: Int?
    let category: String
    let name: String
    let description: String
    let image: String
    
    var set: Int? = 0
    var rep: Int? = 0
    var weight: Int? = 0
    
//    Для настройки каждого подхода
//    var approaches: [Approach]
    
    var comment: String? = ""
    
    static func getExercises() -> [Exercise] {
        [Exercise(id: UUID(), queue: 2, category: "legs", name: "Жим ног", description: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", image: "http://127.0.0.1:8080/images/leg_press.png", set: 3, rep: 2, weight: 55, comment: "с резинками"),Exercise(id: UUID(), queue: 4, category: "legs", name: "Жим ног", description: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", image: "http://127.0.0.1:8080/images/leg_press.png", set: 3, rep: 2, weight: 55, comment: "с резинками"),Exercise(id: UUID(), queue: 6, category: "legs", name: "Жим ног", description: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", image: "http://127.0.0.1:8080/images/leg_press.png", set: 3, rep: 2, weight: 55, comment: "с резинками")]
    }
}

struct Approach {
    var reiteration = 0
    var weight = 0
}
