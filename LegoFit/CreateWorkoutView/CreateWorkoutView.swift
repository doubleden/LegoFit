//
//  CreateWorkoutView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutView: View {
    @Bindable var createWorkoutVM: CreateWorkoutViewViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if createWorkoutVM.isLoading {
                    LoadingView()
                } else {
                    List(createWorkoutVM.exercises) { exercise in
                        NavigationLink(exercise.name, destination: CreateWorkoutDetailsView(exercise: exercise))
                    }
                }
            }
            .navigationTitle("Exercises")
            .onAppear {
                createWorkoutVM.fetchExercises()
            }
            .alert(createWorkoutVM.errorMessage ?? "",
                   isPresented: $createWorkoutVM.showAlert,
                   actions: {} 
            )
        }
    }
}

#Preview {
    CreateWorkoutView(createWorkoutVM: CreateWorkoutViewViewModel())
}
