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
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            MainGradientBackground()
                .ignoresSafeArea()
                .onTapGesture {
                    isFocused = false
                }
            VStack(spacing: 0) {
                if createWorkoutVM.isAddingLap {
                    ElementsForInteractWithLap(
                        viewModel: $createWorkoutVM,
                        isFocused: $isFocused
                    )
                }
                
                FetchedExerciseListView(viewModel: $createWorkoutVM)
            }
            .padding(.top, 20)
            
            // Экран сохранения
            .sheet(isPresented: $createWorkoutVM.isSaveSheetPresented,
                   onDismiss: {
                if createWorkoutVM.isDidSave {
                    dismiss()
                }
            }) {
                CreateWorkoutSaveView( createWorkoutVM: createWorkoutVM ) .presentationDragIndicator(.visible)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Exercises")
        .navigationBarTitleDisplayMode(.inline)
        
        // MARK: - ToolBar
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    createWorkoutVM.cancelCreateWorkout(
                        modelContext: modelContext
                    )
                    dismiss()
                }
                .tint(.main)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    if createWorkoutVM.isAddingLap {
                        isFocused = false
                        createWorkoutVM.clearLapInputs()
                    } 
                    withAnimation(.smooth) {
                        createWorkoutVM.isAddingLap.toggle()
                    }
                }, label: {
                    Image(systemName: createWorkoutVM.isAddingLap ? "figure.run.square.stack.fill" : "figure.run.square.stack")
                        .tint(.main)
                })
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Workout") {
                    createWorkoutVM.isSaveSheetPresented.toggle()
                }
                .disabled(createWorkoutVM.isExercisesInWorkoutEmpty())
                .tint(.main)
            }
            
        }
        
        // MARK: - Alerts
        .alert(createWorkoutVM.errorMessage ?? "",
               isPresented: $createWorkoutVM.isAlertPresented) {
            Button("Ok", role: .cancel) {}
        }
        
        .onAppear {
            createWorkoutVM.fetchExercises()
        }
        
        .onDisappear {
            createWorkoutVM.isAddingLap = false
        }
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    
    return NavigationStack {
        CreateWorkoutView()
            .modelContainer(container)
    }
}
