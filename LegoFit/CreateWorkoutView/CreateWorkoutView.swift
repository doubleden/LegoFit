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
            ZStack {
                List(createWorkoutVM.exercisesDTO) { exercise in
                    Button(exercise.name) {
                        createWorkoutVM.showSheetOf(exercise: exercise)
                        
                    }
                    .tint(.green)
                    .swipeActions(edge: .leading, allowsFullSwipe:true) {
                        Button("Add", action: {
                            createWorkoutVM.addToWorkout(exerciseDTO: exercise)
                        })
                        .tint(.green)
                    }
                }
                .sheet(item: $createWorkoutVM.sheetExercise) { exercise in
                    CreateWorkoutDetailsView(
                        exercise: exercise,
                        createWorkoutVM: $createWorkoutVM
                    )
                }
                
                if createWorkoutVM.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.5)
                }
            }
            .navigationTitle("Добавьте упражнения")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Далее") {
                        createWorkoutVM.isSaveSheetPresented.toggle()
                    }
                    .disabled(createWorkoutVM.isExercisesInWorkoutEmpty())
                }
            }
            .sheet(isPresented: $createWorkoutVM.isSaveSheetPresented) {
                CreateWorkoutSaveView(workoutTitle: $createWorkoutVM.workoutDTO.name) { createWorkoutVM.saveWorkout(modelContext: modelContext)
                    selectedTab = 0
                }
                .presentationDetents([.height(180)])
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
    CreateWorkoutView(selectedTab: .constant(1))
}
