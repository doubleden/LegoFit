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
                            sets: $myWorkoutDetailsVM.set,
                            reps: $myWorkoutDetailsVM.rep,
                            weight: $myWorkoutDetailsVM.weight,
                            comment: $myWorkoutDetailsVM.comment,
                            isAddingLaps: myWorkoutDetailsVM.isLap,
                            isFocused: $isFocused
                        )
                        
                        SaveButton {
                            myWorkoutDetailsVM.saveСhanges()
                            dismiss()
                        }
                    }
                    .onAppear {
                        myWorkoutDetailsVM.setupTextFields()
                    }
                    .padding()
                    .padding(.top, 10)
                }
                .onTapGesture {
                    isFocused = nil
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
