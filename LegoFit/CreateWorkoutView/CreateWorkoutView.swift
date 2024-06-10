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
                        createWorkoutVM.showSheetOf(exercise: exercise)
                        
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe:true) {
                        Button("Add", action: {
                            createWorkoutVM.addToWorkout(exerciseDTO: exercise)
                        })
                        .tint(.green)
                    }
                    //TODO: сделать мини sheet для заполнения реп, сэт, веса
                }
                .sheet(item: $createWorkoutVM.sheetExercise) { exercise in
                    CreateWorkoutDetailsView(exercise: exercise, createWorkoutVM: $createWorkoutVM)
                }
                
                if createWorkoutVM.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.5)
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
                    isPresented: $createWorkoutVM.isShowAlertPresented) {
                Button("Ok", role: .cancel) { createWorkoutVM.workoutDTO.name = ""
                }
            }
            
            .refreshable {
                createWorkoutVM.fetchExercises()
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
