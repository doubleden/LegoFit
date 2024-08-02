//
//  FetchedListView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import SwiftUI

protocol FetchedListViewable: ExerciseDetailsViewable {
    var sortedByCategoryExercises: [String: [Exercise]] { get }
    func showSheetOf(exercise: Exercise)
    func fetchExercises()
}

struct FetchedExerciseListView<ViewModel: FetchedListViewable>: View {
    @Binding var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: -1) {
            Divider()
            
            List(
                Array(viewModel.sortedByCategoryExercises.keys.sorted()),
                id: \.self
            ) { section in
                Section(section) {
                    ForEach(
                        viewModel.sortedByCategoryExercises[section] ?? []
                    ) { exercise in
                        Button(action: {
                            viewModel.showSheetOf(exercise: exercise)
                        }, label: {
                            Text(exercise.name)
                                .foregroundStyle(.white)
                            
                        })
                        .swipeActions(edge: .leading, allowsFullSwipe:true) {
                            Button(action: {
                                viewModel.add(exercise: exercise)
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
                viewModel.fetchExercises()
            }
        }
        .sheet(item: $viewModel.sheetExercise) { _ in
            ExerciseDetailsView(viewModel: $viewModel)
                .presentationBackground(.black)
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    let container = DataController.previewContainer
    return FetchedExerciseListView(viewModel: .constant(CreateWorkoutViewModel()))
        .modelContainer(container)
}
