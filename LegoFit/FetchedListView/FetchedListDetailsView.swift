//
//  CreateWorkoutDetailsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct FetchedListDetailsView<ViewModel: FetchedListViewable>: View {
    @Binding var viewModel: ViewModel
    @State private var fetchedListDetailsVM = FetchedListDetailsViewModel()
    private var exercise: Exercise {
        viewModel.sheetExercise ?? Exercise.getExercises()[0]
    }
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: FocusedTextField?
    
    var body: some View {
        NavigationStack {
            ZStack {
                MainGradientBackground()
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        LabelGradientBackground(
                            content:
                                Text(exercise.name)
                                    .font(.title)
                        )
                        
                        ExerciseImageView(imageUrl: exercise.image)
                            .shadow(color: .main, radius: 10, x: 3, y: 3)
                        
                        Text(exercise.description)
                            .font(.subheadline)
                        
                        ExerciseParametersTF(
                            sets: $fetchedListDetailsVM.approachInputExercise,
                            reps: $fetchedListDetailsVM.repInputExercise,
                            weight: $fetchedListDetailsVM.weightInputExercise,
                            comment: $fetchedListDetailsVM.commentInputExercise,
                            isAddingLaps: viewModel.isAddingLap,
                            isFocused: $isFocused
                        )
                    }
                    .padding(.top, 10)
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Cancel") {
                                dismiss()
                            }
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Add") {
                                guard let exercise = fetchedListDetailsVM.makeChangesInExercise(exercise: viewModel.sheetExercise) else {
                                    return
                                }
                                viewModel.add(exercise: exercise)
                                dismiss()
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 65)
                }
            }
        }
        .tint(.main)
        
        .onTapGesture {
            isFocused = nil
        }
        
        .onDisappear {
            fetchedListDetailsVM.clearExerciseInputs()
        }
    }
}


#Preview {
    let container = DataController.previewContainer
    return FetchedListDetailsView(viewModel: .constant(CreateWorkoutViewModel()))
        .modelContainer(container)
}
