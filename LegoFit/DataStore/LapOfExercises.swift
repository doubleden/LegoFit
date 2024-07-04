//
//  LapOfExercises.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/7/24.
//

import Foundation
import SwiftData

@Model
final class LapOfExercises {
    var queue: Int
    var quantity: Int
    @Relationship(deleteRule: .cascade) var exercises: [Exercise]
    
    init(queue:Int, laps: Int, exercises: [Exercise]) {
        self.quantity = laps
        self.exercises = exercises
        self.queue = queue
    }
    
    convenience init(item: LapDTO) {
        self.init(
            queue: item.queue ?? 0,
            laps: item.set,
            exercises: item.exercises.map { Exercise(item: $0) }
        )
    }
    
    static func getLaps() -> [LapOfExercises] {
        [
            LapOfExercises(queue: 1, laps: 3, exercises: Exercise.getExercises()),
            LapOfExercises(queue: 3, laps: 2, exercises: Exercise.getExercises()),
            LapOfExercises(queue: 5, laps: 2, exercises: Exercise.getExercises())
        ]
    }
}
