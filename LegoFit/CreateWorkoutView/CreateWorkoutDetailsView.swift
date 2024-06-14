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
                    ExerciseImageView(imageUrl: exercise.image)
                        .shadow(color: .main, radius: 20)
                    
                    Text(exercise.name)
                        .font(.title)
                    
                    Text(exercise.description)
                        .font(.subheadline)
                    ExerciseInputFields(
                        sets: $createWorkoutVM.setInputExercise,
                        reps: $createWorkoutVM.repInputExercise,
                        weight: $createWorkoutVM.weightInputExercise,
                        isFocused: _isFocused
                    )
                    
                    Spacer()
                }
                .padding()
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
                                createWorkoutVM.isFocused == .weight
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

struct ExerciseInputFields: View {
    @Binding var sets: String
    @Binding var reps: String
    @Binding var weight: String
    @FocusState var isFocused: FocusedTextField?
    
    var body: some View {
        VStack {
            TextField("Подходы", text: $sets)
                .focused($isFocused, equals: .sets)
            TextField("Повторения", text: $reps)
                .focused($isFocused, equals: .reps)
            TextField("Вес", text: $weight)
                .focused($isFocused, equals: .weight)
        }
        .keyboardType(.numberPad)
        .textFieldStyle(.roundedBorder)
    }
}

#Preview {
    CreateWorkoutDetailsView(exercise: ExerciseDTO.getExercise(), createWorkoutVM: .constant(CreateWorkoutViewViewModel()))
}
