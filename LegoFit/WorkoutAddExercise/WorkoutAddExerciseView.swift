//
//  WorkoutEditView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import SwiftUI

struct WorkoutAddExerciseView: View {
    @State var workout: Workout
    @FocusState private var isFocused
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            ZStack {
                MainGradientBackground()
                    .ignoresSafeArea()
                ExerciseListAddView(
                    exerciseListVM: ExerciseListAddViewModel(
                        workout: workout
                    ),
                    isFocused: $isFocused
                )
            }
            .onChange(of: workout.exercises) { _, _ in
                dismiss()
            }
        }
    }
}

#Preview {
    let container = DataController.previewContainer
    return WorkoutAddExerciseView(workout: Workout.getWorkout())
        .modelContainer(container)
}
