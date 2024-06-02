//
//  CreateWorkoutDetailsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutDetailsView: View {
    
    let createWorkoutVM = CreateWorkoutViewViewModel()
    let exercise: ExerciseDTO
    
    var body: some View {
        VStack(spacing: 10) {
            ExerciseImageView(imageUrl: exercise.image)
            
            Text(exercise.name)
                .font(.title)
            
            Text(exercise.description)
                .font(.subheadline)
            
            Spacer()
            
            Button("Add Exercise", action: {createWorkoutVM.addToWorkout(exerciseDTO: exercise)})
                .buttonStyle(.borderedProminent)
                .tint(.green)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    CreateWorkoutDetailsView(exercise: ExerciseDTO.getExercise())
}
