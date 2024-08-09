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
        ZStack {
            VStack(spacing: 0) {
                Divider()
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
                        ForEach(fetchedListVM.exerciseCategoriesAll) { category in
                            CategoryButton(title: category.title) {
                                fetchedListVM.showFiltered(category: category)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                .frame(height: 60)
                
                List(fetchedListVM.exercisesCategories) { category in
                    Section {
                        ForEach(
                            category.exercises
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
                                .tint(.night)
                            }
                            .mainRowStyle()
                        }
                    } header: {
                        VStack {
                            HStack {
                                Text(category.title)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 16))
                                Spacer()
                            }
                            Divider()
                        }
                    }
                }
                .mainListStyle()
                .background(.clear)
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
            
            if fetchedListVM.isFetching {
                ProgressView {
                    Text("loading...")
                }
                .progressViewStyle(.circular)
                .tint(.white)
            }
        }
    }
}

#Preview {
    let container = DataController.previewContainer
    return FetchedExerciseListView(viewModel: .constant(ExerciseListAddViewModel(workout: Workout.getWorkout())))
        .modelContainer(container)
}
