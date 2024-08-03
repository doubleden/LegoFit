//
//  FetchedListView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import SwiftUI

protocol FetchedListViewable {
    var sheetExercise: Exercise? { get set }
    var isAddingLap: Bool { get set }
    func add(exercise: Exercise)
}

struct FetchedExerciseListView<ViewModel: FetchedListViewable>: View {
    @Binding var viewModel: ViewModel
    
    @State var errorMessage: String? = nil
    @State var isAlertPresented = false
    var sortedByCategoryExercises: [String: [Exercise]] {
        [
            "Legs" : exercises.filter { $0.category == "legs" },
            "Chest" : exercises.filter { $0.category == "chest" },
            "Shoulders" : exercises.filter {$0.category == "shoulders" },
            "Back" : exercises.filter { $0.category == "back" },
            "Arms" : exercises.filter { $0.category == "arms" }
        ]
    }
    
    @State private var exercises: [Exercise] = []
    private let networkManager = NetworkManager.shared
    
    var body: some View {
        VStack(spacing: -1) {
            Divider()
            
            List(
                Array(sortedByCategoryExercises.keys.sorted()),
                id: \.self
            ) { section in
                Section(section) {
                    ForEach(
                        sortedByCategoryExercises[section] ?? []
                    ) { exercise in
                        Button(action: {
                            showSheetOf(exercise: exercise)
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
                fetchExercises()
            }
        }
        .onAppear {
            fetchExercises()
        }
        .sheet(item: $viewModel.sheetExercise) { _ in
            ExerciseDetailsView(viewModel: $viewModel)
                .presentationBackground(.black)
                .presentationDragIndicator(.visible)
        }
        .alert(errorMessage ?? "",
               isPresented: $isAlertPresented) {
            Button("Ok", role: .cancel) {}
        }
    }
    
    private func fetchExercises() {
        Task {
            do {
                exercises = try await networkManager.fetchExercise()
            } catch {
                exercises = []
                errorMessage = error.localizedDescription
                isAlertPresented.toggle()
            }
        }
    }
    
    private func showSheetOf(exercise: Exercise) {
        viewModel.sheetExercise = exercise
    }
}

#Preview {
    let container = DataController.previewContainer
    return FetchedExerciseListView(viewModel: .constant(CreateWorkoutViewModel()))
        .modelContainer(container)
}
