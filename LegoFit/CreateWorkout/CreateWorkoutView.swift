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
            VStack {
                
                ExerciseList(createWorkoutVM: $createWorkoutVM)
                    .sheet(item: $createWorkoutVM.sheetExercise) { exercise in
                        CreateWorkoutDetailsView(
                            exercise: exercise,
                            createWorkoutVM: $createWorkoutVM
                        )
                        .presentationBackground(.black)
                        .presentationDragIndicator(.visible)
                    }
                
                // Нажатие на кнопку Готово и переход к SaveView
                    .sheet(isPresented: $createWorkoutVM.isSaveSheetPresented, onDismiss: {
                        if createWorkoutVM.workout.exercises.isEmpty {
                            dismiss()
                        }
                    }) {
                    CreateWorkoutSaveView(
                        createWorkoutVM: createWorkoutVM
                    )
                    .presentationDragIndicator(.visible)
                }
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("Exercises")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ButtonToolbar(
                        title: "Cancel",
                        action: { createWorkoutVM.cancelCreateWorkout(modelContext: modelContext)
                            dismiss()
                        }
                    )
                }
                // MARK: - Функционал для заполнения лапов
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button(action: {
//                        if !createWorkoutVM.isAddingLaps {
//                            createWorkoutVM.isAddingLaps.toggle()
//                            createWorkoutVM.isAlertForLapsPresented.toggle()
//                        } else {
//                            createWorkoutVM.isAddingLaps.toggle()
//                            createWorkoutVM.addToWorkoutLap()
//                        }
//                    }, label: {
//                        Image(systemName: createWorkoutVM.isAddingLaps
//                              ? "checkmark.rectangle.stack"
//                              : "rectangle.badge.checkmark")
//                    })
//                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    ButtonToolbar(title: "Workout") {
                        createWorkoutVM.isSaveSheetPresented.toggle()
                    }
                    .disabled(createWorkoutVM.isExercisesInWorkoutEmpty())
                }
            }
            .alert("Введите сколько кругов вы хотите", isPresented: $createWorkoutVM.isAlertForLapsPresented, actions: {
                TextField("0", text: $createWorkoutVM.lapInput)
                Button("Готово", action: {})
                Button("Отменить", action: {
                    createWorkoutVM.isAddingLaps.toggle()
                })
            })
            
            .alert(createWorkoutVM.errorMessage ?? "",
                    isPresented: $createWorkoutVM.isShowAlertPresented) {
                Button("Ok", role: .cancel) { 
                    createWorkoutVM.workout.name = ""
                }
            }
            
            .refreshable {
                createWorkoutVM.fetchExercises()
            }
            
            .onAppear {
                createWorkoutVM.fetchExercises()
            }
        }
    }
}

fileprivate struct ExerciseList: View {
    @Binding var createWorkoutVM: CreateWorkoutViewModel
    
    var body: some View {
        List(
            Array(createWorkoutVM.sortedByCategoryExercises.keys.sorted()),
            id: \.self
        ) { section in
            Section(section) {
                ForEach(
                    createWorkoutVM.sortedByCategoryExercises[section] ?? []
                ) { exercise in
                    Button(action: {
                        createWorkoutVM.showSheetOf(exercise: exercise)
                    }, label: {
                        Text(exercise.name)
                            .foregroundStyle(.white)
                            
                    })
                    .swipeActions(edge: .leading, allowsFullSwipe:true) {
                        Button(action: {
                            if createWorkoutVM.isAddingLaps {
                                createWorkoutVM.addToLap(exercise: exercise)
                            } else {
                                var mutableExercise = exercise
                                createWorkoutVM.addToWorkout(exercise: &mutableExercise)
                            }
                        }, label: {
                            Image(systemName: "plus.circle.dashed")
                        })
                        .tint(.main)
                    }
                    .mainRowStyle()
                }
            }
        }
        .mainListStyle()
        .background(
            MainGradientBackground()
        )
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    
    return CreateWorkoutView()
        .modelContainer(container)
}
