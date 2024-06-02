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
                            exercise: exercise
                        )
                    )
                        
                    .swipeActions(edge: .leading, allowsFullSwipe:true) {
                        Button("Add", action: {
                            //TODO: Логика по добавлению упражнения в тренировку
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
                        self.presentationMode.wrappedValue.dismiss()
                        //TODO: Логика по сохранению тренировки
                        createWorkoutVM.saveWorkout(modelContext: modelContext)
                    })
                }
            }
            
            .onAppear {
                createWorkoutVM.fetchExercises()
            }
            
            .onDisappear {
                //TODO: Логика по отмене создания тренировки
                createWorkoutVM.cancelCrateWorkout()
            }
        }
    }
}

#Preview {
    CreateWorkoutView()
}
