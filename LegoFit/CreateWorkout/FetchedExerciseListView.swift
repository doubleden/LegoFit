//
//  FetchedExerciseList.swift
//  LegoFit
//
//  Created by Denis Denisov on 21/7/24.
//

import SwiftUI

struct FetchedExerciseListView: View {
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
                            if createWorkoutVM.isAddLapPresented {
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
        .refreshable {
            createWorkoutVM.fetchExercises()
        }
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    
    return FetchedExerciseListView(createWorkoutVM: .constant(CreateWorkoutViewModel()))
        .modelContainer(container)
}
