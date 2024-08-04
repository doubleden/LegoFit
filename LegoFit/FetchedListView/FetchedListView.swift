//
//  FetchedListView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import SwiftUI

protocol FetchedListViewable {
    var workout: Workout { get set }
    var sheetExercise: Exercise? { get set }
    var isAddingLap: Bool { get set }
    func add(exercise: Exercise)
}

struct FetchedExerciseListView<ViewModel: FetchedListViewable>: View {
    @Binding var viewModel: ViewModel
    @State private var fetchedListVM = FetchedListViewModel()
    
    var body: some View {
        VStack(spacing: -1) {
            Divider()
            
            List(
                Array(fetchedListVM.sortedByCategoryExercises.keys.sorted()),
                id: \.self
            ) { section in
                Section(section) {
                    ForEach(
                        fetchedListVM.sortedByCategoryExercises[section] ?? []
                    ) { exercise in
                        Button(action: {
                            viewModel.sheetExercise = exercise
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
                fetchedListVM.fetchExercises()
            }
        }
        .onAppear {
            fetchedListVM.fetchExercises()
        }
        .sheet(item: $viewModel.sheetExercise) { _ in
            FetchedListDetailsView(viewModel: $viewModel)
                .presentationBackground(.black)
                .presentationDragIndicator(.visible)
        }
        .alert(fetchedListVM.errorMessage ?? "",
               isPresented: $fetchedListVM.isAlertPresented) {
            Button("Ok", role: .cancel) {}
        }
    }
}

#Preview {
    let container = DataController.previewContainer
    return FetchedExerciseListView(viewModel: .constant(ExerciseListViewModel(workout: Workout.getWorkout())))
        .modelContainer(container)
}
