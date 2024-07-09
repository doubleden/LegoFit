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
    
    var body: some View {
        NavigationStack {
            CategoryList(createWorkoutVM: $createWorkoutVM)
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
                        workoutTitle: $createWorkoutVM.workout.name,
                        isInputValid: createWorkoutVM.isWorkoutNameValid()
                    ) { createWorkoutVM.saveWorkout(
                        modelContext: modelContext
                    )
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            createWorkoutVM.cancelCreateWorkout(modelContext: modelContext)
                        }
                    }
                    .presentationBackground(.cellBackground)
                    .presentationDetents([.height(190)])
                    .presentationDragIndicator(.visible)
                }
            }
            .navigationTitle("Exercises")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                //TODO: Надо сделать бургер с кнопками сбросить и фильтр
                ToolbarItem(placement: .topBarLeading) {
                    ButtonToolbar(
                        title: "Reset",
                        action: { createWorkoutVM.cancelCreateWorkout(modelContext: modelContext)
                        }
                    )
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if !createWorkoutVM.isAddingLaps {
                            createWorkoutVM.isAddingLaps.toggle()
                            createWorkoutVM.isAlertForLapsPresented.toggle()
                        } else {
                            createWorkoutVM.isAddingLaps.toggle()
                            createWorkoutVM.addToWorkoutLap()
                        }
                    }, label: {
                        Image(systemName: createWorkoutVM.isAddingLaps
                              ? "checkmark.rectangle.stack"
                              : "rectangle.badge.checkmark")
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    ButtonToolbar(title: "Done") {
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

fileprivate struct CategoryList: View {
    @Binding var createWorkoutVM: CreateWorkoutViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(
                    Array(createWorkoutVM.sortedByCategoryExercises.keys.sorted()),
                    id: \.self
                ) { category in
                    Button(action: {}, label: {
                        Text(category)
                            .foregroundStyle(.white)
                            .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
                    })
                    .background(Gradient(colors: [.gray, .indigo]))
                    .clipShape(Capsule())
//                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .frame(height: 60)
        .scrollIndicators(.hidden)
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
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    
    return CreateWorkoutView()
        .modelContainer(container)
}
