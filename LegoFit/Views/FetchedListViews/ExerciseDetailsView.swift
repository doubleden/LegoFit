//
//  CreateWorkoutDetailsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

protocol ExerciseDetailsViewable {
    var sheetExercise: Exercise? { get set }
    var approachInputExercise: String { get set }
    var repInputExercise: String { get set }
    var weightInputExercise: String { get set }
    var commentInputExercise: String { get set }
    var isAddingLap: Bool { get }
    func makeChangesInExercise() -> Exercise?
    func add(exercise: Exercise)
    func clearExerciseInputs()
}

struct ExerciseDetailsView<ViewModel: ExerciseDetailsViewable>: View {
    @Binding var viewModel: ViewModel
    
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
                            sets: $viewModel.approachInputExercise,
                            reps: $viewModel.repInputExercise,
                            weight: $viewModel.weightInputExercise,
                            comment: $viewModel.commentInputExercise,
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
                                guard let exercise = viewModel.makeChangesInExercise() else {
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
            viewModel.clearExerciseInputs()
        }
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    return ExerciseDetailsView(viewModel: .constant(CreateWorkoutViewModel()))
        .modelContainer(container)
}
