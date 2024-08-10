//
//  MyWorkoutEditExerciseView.swift
//  LegoFit
//
//  Created by Denis Denisov on 21/6/24.
//

import SwiftUI

struct MyWorkoutEditExerciseView: View {
    @Bindable var myWorkoutDetailsVM: MyWorkoutEditExerciseViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: FocusedTextField?
    
    var body: some View {
        NavigationStack {
            ZStack {
                MainGradientBackground()
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        ExerciseParametersTF(
                            approach: $myWorkoutDetailsVM.approach,
                            repetition: $myWorkoutDetailsVM.rep,
                            weight: $myWorkoutDetailsVM.weight,
                            comment: $myWorkoutDetailsVM.comment,
                            isAddingLaps: myWorkoutDetailsVM.isLap,
                            isFocused: $isFocused
                        )
                    }
                    .onAppear {
                        myWorkoutDetailsVM.setupTextFields()
                    }
                    .padding()
                }
                .onTapGesture {
                    isFocused = nil
                }
            }
            .navigationTitle(myWorkoutDetailsVM.exercise.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    SaveButton {
                        if myWorkoutDetailsVM.weight.isEmpty {
                            myWorkoutDetailsVM.weight = "0"
                        }
                        myWorkoutDetailsVM.saveСhanges()
                        dismiss()
                    }
                }
            }
        }
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    let workouts = try? container.mainContext.fetch(FetchDescriptor<Workout>())
    let workout = workouts?.first ?? Workout.getWorkout()
    let exercise = Exercise.getExercises().first!
    
    return MyWorkoutEditExerciseView(myWorkoutDetailsVM: MyWorkoutEditExerciseViewModel(exercise: exercise, exerciseType: .single(exercise), workout: workout))
}
