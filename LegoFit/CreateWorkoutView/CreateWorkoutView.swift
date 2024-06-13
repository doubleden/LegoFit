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
                ExerciseList(createWorkoutVM: $createWorkoutVM)
                
                if createWorkoutVM.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(1.5)
                }
            }
            .navigationTitle("Упражнения")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Далее") {
                        createWorkoutVM.isSaveSheetPresented.toggle()
                    }
                    .tint(.main)
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
                    ExerciseCellView(title: exercise.name) {
                            createWorkoutVM.showSheetOf(exercise: exercise)
                        } onSwipeAction: {
                            createWorkoutVM.addToWorkout(exerciseDTO: exercise)
                        }
                }
            } header: {
                Text(section)
                //TODO: Разукрасить
            }
        }
        .sheet(item: $createWorkoutVM.sheetExercise) { exercise in
            CreateWorkoutDetailsView(
                exercise: exercise,
                createWorkoutVM: $createWorkoutVM
            )
        }
    }
}

#Preview {
    CreateWorkoutView(selectedTab: .constant(1))
}
