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
                    
                    Text(exercise.name)
                        .font(.title)
                    
                    Text(exercise.description)
                        .font(.subheadline)
                    
                    VStack {
                        TextField("sets", text: $createWorkoutVM.setInputExercise)
                            .focused($isFocused, equals: .sets)
                        TextField("reps", text: $createWorkoutVM.repInputExercise)
                            .focused($isFocused, equals: .reps)
                        TextField("weight", text: $createWorkoutVM.weightInputExercise)
                            .focused($isFocused, equals: .weight)
                    }
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    
                    Spacer()
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: { dismiss() }, label: {
                            Text("Cancel")
                        })
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            createWorkoutVM.addToWorkout(exerciseDTO: exercise)
                            dismiss()
                        }, label: {
                            Text("Add")
                        })
                    }
                    
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button("Done") {
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
    }
}

#Preview {
    CreateWorkoutDetailsView(exercise: ExerciseDTO.getExercise(), createWorkoutVM: .constant(CreateWorkoutViewViewModel()))
}
