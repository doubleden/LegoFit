//
//  Exercise.swift
//  LegoFit
//
//  Created by Denis Denisov on 29/6/24.
//

import Foundation

struct Exercise: Codable, Identifiable, Equatable, Hashable {
    var id = UUID()
    let category: String
    let name: String
    let description: String
    let image: String
    
    var approach: Int? = 0
    var rep: Int? = 0
    var weight: String? = "0"
    var comment: String? = ""
    
//    Для настройки каждого подхода
//    var approaches: [Approach]
    
}

//struct Approach {
//    var repetition = 0
//    var weight = 0
//}

// MARK: - ДЛЯ Preview
extension Exercise {
    static func getExercises() -> [Exercise] {
        [Exercise(id: UUID(), category: "legs", name: "Жим ног", description: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", image: "https://legofit.es/images/leg_press.png", approach: 3, rep: 2, weight: "55", comment: "с резинками"),Exercise(id: UUID(), category: "legs", name: "Жим ног", description: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", image: "https://legofit.es/images/leg_press.png", approach: 3, rep: 2, weight: "55", comment: "с резинками"),Exercise(id: UUID(), category: "legs", name: "Жим ног", description: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", image: "https://legofit.es/images/leg_press.png", approach: 3, rep: 2, weight: "55", comment: "с резинками")]
    }
}
