//
//  CreateWorkoutView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutView: View {
    @State var createWorkoutVM = CreateWorkoutViewViewModel()
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
                    //TODO: сделать алерт для реп, сэт, веса
                }
                .sheet(item: $createWorkoutVM.sheetExercise) { exercise in
                    CreateWorkoutDetailsView(exercise: exercise, createWorkoutVM: $createWorkoutVM)
                }
                
                .refreshable {
                    createWorkoutVM.fetchExercises()
                }
                    
                if createWorkoutVM.isLoading {
                    LoadingView()
                }
            }
            .navigationTitle("Exercises")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save Workout") {
                        createWorkoutVM.saveWorkout(modelContext: modelContext)
                        if !createWorkoutVM.isShowAlertPresented {
                            dismiss()
                        }
                    }
                }
            }
            .alert(createWorkoutVM.errorMessage ?? "",
                    isPresented: $createWorkoutVM.isShowAlertPresented,
                    actions: {}
            )
            
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
