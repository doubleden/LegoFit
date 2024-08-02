//
//  MyWorkoutViewViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import Observation
import Foundation

@Observable
final class MyWorkoutViewModel {
    var isWorkoutStart = false
    
    var sheetExercise: Exercise?
    var sheetExerciseType: ExerciseType?
    
    var sheetEditLap: Lap?
    
    var isAlertPresented = false
    var alertMessage: String?
    
    var exercises: [ExerciseType] {
        workout.exercises
    }
    
    let workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    func startWorkout() {
        guard isExercisesValid() else {
            isAlertPresented.toggle()
            alertMessage = "Проверьте заполнение параметров всех упражнений.\nПодход и повторения должны быть больше 0"
            return
        }
        isWorkoutStart.toggle()
    }
    
    func showDetailsView(exercise: Exercise, type: ExerciseType) {
        sheetExercise = exercise
        sheetExerciseType = type
    }
    
    func showEditLapView(lap: Lap) {
        sheetEditLap = lap
    }
    
    func moveCell(from source: IndexSet, to destination: Int) {
        workout.exercises.move(fromOffsets: source, toOffset: destination)
    }
    
    func moveExercise(in lap: Lap, from source: IndexSet, to destination: Int) {
        guard let lapIndex = workout.findIndex(ofLap: lap) else { return }
        var updatedLap = lap
        updatedLap.exercises.move(fromOffsets: source, toOffset: destination)
        workout.exercises[lapIndex] = .lap(updatedLap)
    }
    
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [unowned self] in
                    workout.exercises.remove(at: lapIndex)
                }
            }
        }
    }
    
    private func isExercisesValid() -> Bool {
        var isValid = true
        for exercise in exercises {
            switch exercise {
            case .single(let exercise):
                if (exercise.approach ?? 0) <= 0 || (exercise.rep ?? 0) <= 0 {
                    isValid.toggle()
                    break
                }
            case .lap(let lap):
                if lap.quantity <= 0 {
                    isValid.toggle()
                    break
                }
            }
        }
        return isValid
    }
}
