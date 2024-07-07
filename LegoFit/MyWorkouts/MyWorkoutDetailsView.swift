//
//  MyWorkoutDetailsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 21/6/24.
//

import SwiftUI

struct MyWorkoutDetailsView: View {
    @Bindable var myWorkoutDetailsVM: MyWorkoutDetailsViewModel
    
    @Environment(\.dismiss) var dismis
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ExerciseParametersTF(
                    sets: $myWorkoutDetailsVM.set,
                    reps: $myWorkoutDetailsVM.rep,
                    weight: $myWorkoutDetailsVM.weight,
                    comment: $myWorkoutDetailsVM.comment
                )
                
                Button("Save") {
                    myWorkoutDetailsVM.saveСhanges()
                    dismis()
                }
                .buttonStyle(.borderedProminent)
            }
            .onAppear {
                myWorkoutDetailsVM.setupTextFields()
            }
        .padding()
        .padding(.top, 5)
        }
    }
}

#Preview {
    let exercise = Exercise.getExercises().first!
    
    return MyWorkoutDetailsView(myWorkoutDetailsVM: MyWorkoutDetailsViewModel(exercise: exercise))
}
