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
        set: Int,
        rep: Int,
        weight: Int
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
            photo: item.image,
            set: item.set,
            rep: item.rep,
            weight: item.weight
        )
    }
    
    static func getExercises() -> [Exercise] {
        [Exercise(category: "legs", name: "Жим ног", definition: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", photo: "http://127.0.0.1:8080/images/leg_press.png", set: 3, rep: 2, weight: 55),Exercise(category: "legs", name: "Жим ног", definition: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", photo: "http://127.0.0.1:8080/images/leg_press.png", set: 3, rep: 2, weight: 55),Exercise(category: "legs", name: "Жим ног", definition: "Упражнение для прокачки ног, которое выполняется в специальном тренажёре, горизонтальном или вертикальном (наклонном)", photo: "http://127.0.0.1:8080/images/leg_press.png", set: 3, rep: 2, weight: 55)]
    }
}
