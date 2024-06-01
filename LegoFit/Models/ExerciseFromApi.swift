//
//  ExerciseFromApi.swift
//  LegoFit
//
//  Created by Denis Denisov on 28/5/24.
//

struct ExerciseFromApi: Decodable, Identifiable {
    let id: Int
    let category: String
    let name: String
    let description: String
    let image: String
    
    static func getExercise() -> ExerciseFromApi {
        ExerciseFromApi(id: 2, category: "legs", name: "Жим ног", description: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", image: "http://127.0.0.1:8080/images/leg_press.png")
    }
}
