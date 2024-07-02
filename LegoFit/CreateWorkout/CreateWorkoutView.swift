//
//  CreateWorkoutView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutView: View {
    @Binding var selectedTab: Int
    @State var createWorkoutVM = CreateWorkoutViewViewModel()
    @Environment(\.modelContext) private var modelContext
    
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
                .sheet(isPresented: $createWorkoutVM.isSaveSheetPresented) {
                    CreateWorkoutSaveView(
                        workoutTitle: $createWorkoutVM.workoutDTO.name,
                        isInputValid: createWorkoutVM.isWorkoutNameValid()
                    ) { createWorkoutVM.saveWorkout(
                        modelContext: modelContext
                    )
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            createWorkoutVM.cancelCreateWorkout()
                            selectedTab = 0
                        }
                    }
                    .presentationBackground(.cellBackground)
                    .presentationDetents([.height(190)])
                    .presentationDragIndicator(.visible)
                }
            }
            .navigationTitle("Упражнения")
            .toolbar {
                //TODO: Надо сделать бургер с кнопками сбросить и фильтр
                ToolbarItem(placement: .topBarLeading) {
                    ButtonToolbar(
                        title: "Сбросить",
                        action: createWorkoutVM.cancelCreateWorkout
                    )
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if !createWorkoutVM.isAddingLaps {
                            createWorkoutVM.isAddingLaps.toggle()
                            createWorkoutVM.isAlertForLapsPresented.toggle()
                        } else {
                            createWorkoutVM.isAddingLaps.toggle()
                            createWorkoutVM.addToWorkoutLapDTO()
                        }
                    }, label: {
                        Image(systemName: createWorkoutVM.isAddingLaps
                              ? "checkmark.rectangle.stack"
                              : "rectangle.badge.checkmark")
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    ButtonToolbar(title: "Готово") {
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
                    createWorkoutVM.workoutDTO.name = ""
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
    @Binding var createWorkoutVM: CreateWorkoutViewViewModel
    
    var body: some View {
        List(
            Array(createWorkoutVM.sortedByCategoryExercises.keys.sorted()),
            id: \.self
        ) { section in
            Section {
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
                                createWorkoutVM.addToLapDTO(exerciseDTO: exercise)
                            } else {
                                createWorkoutVM.addToWorkout(exerciseDTO: exercise)
                            }
                        }, label: {
                            Image(systemName: "plus.circle.dashed")
                        })
                        .tint(.main)
                    }
                    
                }
            } header: {
                HeaderView(
                    text: section,
                    isLoading: $createWorkoutVM.isLoading
                )
            }
            .listRowBackground(Color.cellBackground)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CreateWorkoutView(selectedTab: .constant(1))
}
