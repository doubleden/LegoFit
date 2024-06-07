//
//  CreateWorkoutView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutView: View {
    @Bindable var createWorkoutVM = CreateWorkoutViewViewModel()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            TextField("Workout Name", text: $createWorkoutVM.workoutDTO.name)
                .textFieldStyle(.roundedBorder)
            ZStack {
                List(createWorkoutVM.exercisesDTO) { exercise in
                    Button(exercise.name) {
                        createWorkoutVM.showDetailsOf(exercise: exercise)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe:true) {
                        Button("Add", action: {
                            createWorkoutVM.addToWorkout(exerciseDTO: exercise)
                        })
                        .tint(.green)
                    }
                }
                .sheet(item: $createWorkoutVM.sheetExercise) { exercise in
                    CreateWorkoutDetailsView(exercise: exercise)
                }
                .refreshable {
                    createWorkoutVM.fetchExercises()
                }
                    
                if createWorkoutVM.isLoading {
                    LoadingView()
                        .alert(createWorkoutVM.errorMessage ?? "",
                                isPresented: $createWorkoutVM.isShowAlertPresented,
                                actions: {}
                        )
                }
            }
            .navigationTitle("Exercises")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save Workout", action: {
                        createWorkoutVM.saveWorkout(modelContext: modelContext)
                        dismiss()
                    })
                }
            }
            
            .onAppear {
                createWorkoutVM.fetchExercises()
            }
            
            .onDisappear {
                createWorkoutVM.cancelCrateWorkout()
            }
        }
    }
}

#Preview {
    CreateWorkoutView()
}
