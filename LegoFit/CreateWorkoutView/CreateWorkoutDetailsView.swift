//
//  CreateWorkoutDetailsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutDetailsView: View {
    let exercise: ExerciseDTO
    
    private let createWorkoutVM = CreateWorkoutViewViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                ExerciseImageView(imageUrl: exercise.image)
                
                Text(exercise.name)
                    .font(.title)
                
                Text(exercise.description)
                    .font(.subheadline)
                
                Spacer()
                
                Button("Add Exercise"){
                    createWorkoutVM.addToWorkout(exerciseDTO: exercise)
                    dismiss()
                }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { dismiss() }, label: {
                        HStack {
                            Text("Hide")
                        }
                    })
                }
            }
        }
    }
}

#Preview {
    CreateWorkoutDetailsView(exercise: ExerciseDTO.getExercise())
}
