//
//  CreateWorkoutViewViewModel.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//
import Observation
import SwiftData
import Foundation

@Observable
final class CreateWorkoutViewModel: ExerciseListCellDeletable {
    var workout: Workout
    var isDidSave = false
    var isSaveSheetPresented = false
    
    var isExercisesInWorkoutEmpty: Bool {
        workout.exercises.isEmpty
    }
    
    var isWorkoutNameValid: Bool {
        !workout.name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var exerciseListAddVM: ExerciseListAddViewModel
    
    private let storageManager = StorageManager.shared
    
    init(workout: Workout = Workout()) {
        self.workout = workout
        self.exerciseListAddVM = ExerciseListAddViewModel(workout: workout)
    }
    func saveWorkout(modelContext: ModelContext) {
        storageManager.save(workout: workout, context: modelContext)
        isDidSave.toggle()
    }
    
    func cancelCreateWorkout() {
        workout = Workout()
        updateExerciseListAddVM()
    }
    
    func delete(lap: Lap) {
        guard let lapIndex = workout.findIndex(ofLap: lap) else { return }
        workout.exercises.remove(at: lapIndex)
    }
    
    func updateExerciseListAddVM() {
        exerciseListAddVM = ExerciseListAddViewModel(workout: workout)
    }
}
