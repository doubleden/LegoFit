//
//  CreateWorkoutView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutView: View {
    
    @State private var createWorkoutVM = CreateWorkoutViewModel()
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            FetchedExerciseListView(createWorkoutVM: $createWorkoutVM)
            
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        ButtonToolbar(
                            title: "Cancel",
                            action: { createWorkoutVM.cancelCreateWorkout(modelContext: modelContext)
                                dismiss()
                            }
                        )
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            createWorkoutVM.isAddLapPresented.toggle()
                        }, label: {
                            Image(systemName: "figure.run.square.stack")
                                .tint(.main)
                        })
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        ButtonToolbar(title: "Workout") {
                            createWorkoutVM.isSaveSheetPresented.toggle()
                        }
                        .disabled(createWorkoutVM.isExercisesInWorkoutEmpty())
                    }
                }
            
            .navigationBarBackButtonHidden()
            .navigationTitle("Exercises")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        // MARK: - Sheets
        // Экран с описание упражнения
        .sheet(item: $createWorkoutVM.sheetExercise) { exercise in
            CreateWorkoutDetailsView(
                exercise: exercise,
                createWorkoutVM: $createWorkoutVM
            )
            .presentationBackground(.black)
            .presentationDragIndicator(.visible)
        }
        
        // Экран сохранения
        .sheet(isPresented: $createWorkoutVM.isSaveSheetPresented,
               onDismiss: {
            if createWorkoutVM.isDidSave {
                dismiss()
            }
        }) {
            CreateWorkoutSaveView( createWorkoutVM: createWorkoutVM ) .presentationDragIndicator(.visible)
        }
        
        // Экран создания Lap
        .sheet(isPresented: $createWorkoutVM.isAddLapPresented) {
            CreateWorkoutAddLapView(createWorkoutVM: $createWorkoutVM)
                .presentationDragIndicator(.visible)
        }
        
        // MARK: - Alerts
        .alert(createWorkoutVM.errorMessage ?? "",
               isPresented: $createWorkoutVM.isAlertPresented) {
            Button("Ok", role: .cancel) {}
        }
        
        .onAppear {
            createWorkoutVM.fetchExercises()
        }
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    
    return CreateWorkoutView()
        .modelContainer(container)
}
