//
//  WorkoutEditView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import SwiftUI

struct WorkoutEditView: View {
    @State var workoutEditVM: WorkoutEditViewModel
    @FocusState private var isFocused
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            ZStack {
                MainGradientBackground()
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    if workoutEditVM.isAddingLap {
                        ElementsForInteractWithLap(
                            viewModel: $workoutEditVM,
                            isFocused: $isFocused
                        )
                    }
                    FetchedExerciseListView(viewModel: $workoutEditVM)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ButtonLap(isAddingLap: $workoutEditVM.isAddingLap)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Spacer()
                }
            }
            .onChange(of: workoutEditVM.workout.exercises) { _, _ in
                dismiss()
            }
        }
    }
}

#Preview {
    let container = DataController.previewContainer
    return WorkoutEditView(workoutEditVM: WorkoutEditViewModel(workout: Workout.getWorkout()))
        .modelContainer(container)
}
