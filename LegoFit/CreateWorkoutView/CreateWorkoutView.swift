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
                    ButtonToolbar(title: "Готово") {
                        createWorkoutVM.isSaveSheetPresented.toggle()
                    }
                    .disabled(createWorkoutVM.isExercisesInWorkoutEmpty())
                }
            }
            
            // Нажатие на кнопку Готово и переход к SaveView
            .sheet(isPresented: $createWorkoutVM.isSaveSheetPresented) {
                CreateWorkoutSaveView(workoutTitle: $createWorkoutVM.workoutDTO.name) { createWorkoutVM.saveWorkout(modelContext: modelContext)
                    if !createWorkoutVM.isShowAlertPresented {
                        createWorkoutVM.cancelCreateWorkout()
                        selectedTab = 0
                    }
                }
                .presentationDetents([.height(190)])
            }
            
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
                    .frame(height: 40)
                    .swipeActions(edge: .leading, allowsFullSwipe:true) {
                        Button(action: {
                            createWorkoutVM.addToWorkout(exerciseDTO: exercise)
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
