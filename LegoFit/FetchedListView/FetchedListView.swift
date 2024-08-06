//
//  FetchedListView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import SwiftUI

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
                Section {
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
                } header: {
                    VStack {
                        HStack {
                            Text(section)
                                .foregroundStyle(.white)
                                .font(.system(size: 16))
                            Spacer()
                            if fetchedListVM.isFetching {
                                ProgressView()
                                    .tint(.main)
                            }
                        }
                        Divider()
                    }
                }
            }
            .mainListStyle()
            .background(
                MainGradientBackground()
            )
            .refreshable {
                Task {
                    await fetchedListVM.refreshExercises()
                }
            }
        }
        .task {
            await fetchedListVM.fetchExercises()
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
    return FetchedExerciseListView(viewModel: .constant(ExerciseListAddViewModel(workout: Workout.getWorkout())))
        .modelContainer(container)
}
