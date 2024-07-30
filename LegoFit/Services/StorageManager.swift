//
//  StorageManager.swift
//  LegoFit
//
//  Created by Denis Denisov on 31/5/24.
//

import SwiftData
import Foundation

final class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}

    func save(workout: Workout, context: ModelContext) {
        context.insert(workout)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    func delete(workout: Workout, context: ModelContext) {
        do {
            context.delete(workout)
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func update(exercise: Exercise, in workout: Workout) {
        if let index = workout.exercises.firstIndex(where: {
            if case .single(let exerciseDB) = $0 {
                return exerciseDB.id == exercise.id
            }
            return false
        }) {
            workout.exercises[index] = .single(exercise)
        }
    }
    
    func update(exercise: Exercise, withLapID: UUID, in workout: Workout) {
        if let lapIndex = workout.exercises.firstIndex(where: {
            if case .lap(let lap) = $0 {
                return lap.id == withLapID
            }
            return false
        }) {
            if case .lap(var lap) = workout.exercises[lapIndex] {
                if let exerciseIndex = lap.exercises.firstIndex(where: { $0.id == exercise.id }) {
                    lap.exercises[exerciseIndex] = exercise
                    workout.exercises[lapIndex] = .lap(lap)
                }
            }
        }
    }
}
