//
//  MyWorkoutDetailsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 21/6/24.
//

import SwiftUI

struct MyWorkoutDetailsView: View {
    @Bindable var myWorkoutDetailsVM: MyWorkoutDetailsViewModel
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
                        
                        Button("Save") {
                            myWorkoutDetailsVM.saveСhanges()
                            dismiss()
                        }
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .background(.main)
                        .tint(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
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
    
    return MyWorkoutDetailsView(myWorkoutDetailsVM: MyWorkoutDetailsViewModel(exercise: exercise, exerciseType: .single(exercise), workout: workout))
}
