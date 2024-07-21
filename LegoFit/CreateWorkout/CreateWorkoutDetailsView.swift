//
//  CreateWorkoutDetailsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutDetailsView: View {
    @Binding var createWorkoutVM: CreateWorkoutViewModel
    
    private var exercise: Exercise {
        createWorkoutVM.sheetExercise ?? Exercise.getExercises()[0]
    }
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: FocusedTextField?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    LabelGradientBackground(content:
                        Text(exercise.name)
                            .font(.title)
                    )
                    
                    ExerciseImageView(imageUrl: exercise.image)
                        .shadow(color: .main, radius: 10, x: 3, y: 3)
                    
                    Text(exercise.description)
                        .font(.subheadline)
                    
                    ExerciseParametersTF(
                        sets: $createWorkoutVM.approachInputExercise,
                        reps: $createWorkoutVM.repInputExercise,
                        weight: $createWorkoutVM.weightInputExercise,
                        comment: $createWorkoutVM.commentInputExercise,
                        isFocused: _isFocused, 
                        isAddingLaps: createWorkoutVM.isAddingLap
                    )
                }
                .padding(.top, 10)
                .padding()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        ButtonToolbar(title: "Cancel") {
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        ButtonToolbar(title: "Add") {
                            guard let exercise = createWorkoutVM.makeChangesInExercise() else {
                                return
                            }
                            createWorkoutVM.add(exercise: exercise)
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button(
                                createWorkoutVM.isFocused == .comment
                                   ? "Done"
                                   : "Next"
                            ) {
                                createWorkoutVM.changeIsFocused()
                                self.isFocused = createWorkoutVM.isFocused
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 65)
            }
        }
        
        .onChange(of: isFocused, { _, newValue in
            createWorkoutVM.isFocused = newValue
        })
        
        .onTapGesture {
            isFocused = nil
        }
        
        .onDisappear {
            createWorkoutVM.clearExerciseInputs()
        }
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    return CreateWorkoutDetailsView(createWorkoutVM: .constant(CreateWorkoutViewModel()))
        .modelContainer(container)
}
