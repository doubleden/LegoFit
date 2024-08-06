//
//  ExerciseListCellDeletable.swift
//  LegoFit
//
//  Created by Denis Denisov on 6/8/24.
//
import Foundation

protocol ExerciseListCellDeletable {
    var workout: Workout { get set }
    func deleteCell(_ indexSet: IndexSet)
    func delete(inLap: Lap, exerciseWith indexSet: IndexSet)
}

extension ExerciseListCellDeletable {
    func deleteCell(_ indexSet: IndexSet) {
        for index in indexSet {
            workout.exercises.remove(at: index)
        }
    }
    
    func delete(inLap: Lap, exerciseWith indexSet: IndexSet) {
        guard let lapIndex = workout.findIndex(ofLap: inLap) else { return }
        if case var .lap(lap) = workout.exercises[lapIndex] {
            for index in indexSet {
                lap.exercises.remove(at: index)
                workout.exercises[lapIndex] = .lap(lap)
            }
            if lap.exercises.isEmpty {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    workout.exercises.remove(at: lapIndex)
                }
            }
        }
    }
}
