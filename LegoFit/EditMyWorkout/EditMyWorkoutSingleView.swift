//
//  WorkoutEditView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import SwiftUI

struct EditMyWorkoutSingleView: View {
    let workout: Workout
    @State private var exerciseListAddVM: ExerciseListAddViewModel
    @FocusState private var isFocused
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                MainGradientBackground()
                    .ignoresSafeArea()
                ExerciseListAddView(
                    exerciseListVM: $exerciseListAddVM,
                    isFocused: $isFocused
                )
            }
            .onChange(of: workout.exercises) { _, _ in
                dismiss()
            }
            .navigationTitle(workout.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
        }
    }
    
    init(workout: Workout) {
        self.workout = workout
        self.exerciseListAddVM = ExerciseListAddViewModel(workout: workout)
    }
}

#Preview {
    let container = DataController.previewContainer
    return EditMyWorkoutSingleView(workout: Workout.getWorkout())
        .modelContainer(container)
}
