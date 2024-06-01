//
//  CreateWorkoutView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutView: View {
    @Bindable var createWorkoutVM = CreateWorkoutViewViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(createWorkoutVM.exercises) { exercise in
                    NavigationLink(
                        exercise.name,
                        destination:CreateWorkoutDetailsView(
                            exercise: exercise
                        )
                    )
                        
                    .swipeActions(edge: .leading, allowsFullSwipe:true) {
                        Button("Add", action: {
                            //TODO: Логика по добавлению упражнения в тренировку
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
                    })
                }
            }
            
            .onAppear {
                createWorkoutVM.fetchExercises()
            }
            
            .onDisappear {
                //TODO: Логика по отмене создания тренировки
            }
        }
    }
}

#Preview {
    CreateWorkoutView()
}
