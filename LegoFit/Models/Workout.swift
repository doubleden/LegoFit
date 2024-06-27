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
    var name: String
    let date = Date()
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
    
    static func getWorkout() -> Workout {
        Workout(name: "First", exercises: Exercise.getExercises())
    }
    
    static func getWorkouts() -> [Workout] {
        [
            Workout(name: "First", exercises: Exercise.getExercises()),
            Workout(name: "Second", exercises: Exercise.getExercises()),
            Workout(name: "Third", exercises: Exercise.getExercises())
        ]
    }
}

@Model
final class Exercise {
    var queue: Int
    let category: String
    let name: String
    let definition: String
    let photo: String
    
    var set: Int
    var rep: Int
    var weight: Int
    var comment: String
    
    init(
        queue: Int,
        category: String,
        name: String,
        definition: String,
        photo: String,
        set: Int,
        rep: Int,
        weight: Int,
        comment: String
    ) {
        self.queue = queue
        self.category = category
        self.name = name
        self.definition = definition
        self.photo = photo
        self.set = set
        self.rep = rep
        self.weight = weight
        self.comment = comment
    }
    
    convenience init(item: ExerciseDTO) {
        self.init(
            queue: item.queue ?? 0,
            category: item.category,
            name: item.name,
            definition: item.description,
            photo: item.image,
            set: item.set ?? 0,
            rep: item.rep ?? 0,
            weight: item.weight ?? 0,
            comment: item.comment ?? ""
        )
    }
    
    static func getExercises() -> [Exercise] {
        [Exercise(queue: 3, category: "legs", name: "Жим ног", definition: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", photo: "http://127.0.0.1:8080/images/leg_press.png", set: 3, rep: 2, weight: 55, comment: "с резинками"),Exercise(queue: 2, category: "legs", name: "Жим ног", definition: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", photo: "http://127.0.0.1:8080/images/leg_press.png", set: 3, rep: 2, weight: 55, comment: "с резинками"),Exercise(queue: 1, category: "legs", name: "Жим ног", definition: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", photo: "http://127.0.0.1:8080/images/leg_press.png", set: 3, rep: 2, weight: 55, comment: "с резинками")]
    }
}
