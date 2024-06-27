//
//  CreateWorkoutDetailsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutDetailsView: View {
    var exercise: ExerciseDTO
    @Binding var createWorkoutVM: CreateWorkoutViewViewModel
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: FocusedTextField?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    GradientBackground(content:
                        Text(exercise.name)
                            .font(.title)
                    )
                    
                    ExerciseImageView(imageUrl: exercise.image)
                        .shadow(color: .main, radius: 10, x: 3, y: 3)
                    
                    Text(exercise.description)
                        .font(.subheadline)
                    
                    ExerciseParametersTF(
                        sets: $createWorkoutVM.setInputExercise,
                        reps: $createWorkoutVM.repInputExercise,
                        weight: $createWorkoutVM.weightInputExercise,
                        comment: $createWorkoutVM.commentInputExercise,
                        isFocused: _isFocused
                    )
                }
                .padding(.top, 10)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        ButtonToolbar(title: "Отменить") {
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        ButtonToolbar(title: "Добавить") {
                            createWorkoutVM.addToWorkout(
                                exerciseDTO: exercise
                            )
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button(
                                createWorkoutVM.isFocused == .comment
                                   ? "Готово"
                                   : "Далее"
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
            createWorkoutVM.clearInputs()
        }
    }
}

#Preview {
    CreateWorkoutDetailsView(exercise: ExerciseDTO.getExercise(), createWorkoutVM: .constant(CreateWorkoutViewViewModel()))
}
