//
//  CreateWorkoutView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutView: View {
    @Bindable var createWorkoutVM = CreateWorkoutViewViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            TextField("Workout Name", text: $createWorkoutVM.workoutDTO.name)
                .textFieldStyle(.roundedBorder)
            ZStack {
                List(createWorkoutVM.exercisesDTO, id: \.name) { exercise in
                    NavigationLink(
                        exercise.name,
                        destination:CreateWorkoutDetailsView(
                            
                            //TODO: При переходе на дитали и назад Тренировка сбрасывается надо сделать модальный переход. Это происходит из за функции .onDisapear
                    
                            createWorkoutVM: createWorkoutVM, exercise: exercise
                        )
                    )
                        
                    .swipeActions(edge: .leading, allowsFullSwipe:true) {
                        Button("Add", action: {
                            createWorkoutVM.addToWorkout(exerciseDTO: exercise)
                        })
                        .tint(.green)
                    }
                }
                .refreshable {
                    createWorkoutVM.fetchExercises()
                }
                    
                if createWorkoutVM.isLoading {
                    LoadingView()
                        .alert(createWorkoutVM.errorMessage ?? "",
                                isPresented: $createWorkoutVM.errorShowAlert,
                                actions: {}
                        )
                }
            }
            .navigationTitle("Exercises")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save Workout", action: {
                        createWorkoutVM.saveWorkout(modelContext: modelContext)
                        self.presentationMode.wrappedValue.dismiss()
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
