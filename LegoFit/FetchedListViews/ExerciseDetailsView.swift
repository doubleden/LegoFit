//
//  CreateWorkoutDetailsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct ExerciseDetailsView<ViewModel: FetchedListViewable>: View {
    @Binding var viewModel: ViewModel
    
    @State var approachInputExercise = ""
    @State var repInputExercise = ""
    @State var weightInputExercise = ""
    @State var commentInputExercise = ""
    
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
                            sets: $approachInputExercise,
                            reps: $repInputExercise,
                            weight: $weightInputExercise,
                            comment: $commentInputExercise,
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
                                guard let exercise = makeChangesInExercise() else {
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
            clearExerciseInputs()
        }
    }
    
    private func clearExerciseInputs() {
        approachInputExercise = ""
        repInputExercise = ""
        weightInputExercise = ""
        commentInputExercise = ""
    }
    
    private func makeChangesInExercise() -> Exercise? {
        guard var exercise = viewModel.sheetExercise else { return nil }
        exercise.approach = Int(approachInputExercise)
        exercise.rep = Int(repInputExercise)
        exercise.weight = weightInputExercise
        exercise.comment = commentInputExercise
        return exercise
    }
}


#Preview {
    let container = DataController.previewContainer
    return ExerciseDetailsView(viewModel: .constant(CreateWorkoutViewModel()))
        .modelContainer(container)
}
