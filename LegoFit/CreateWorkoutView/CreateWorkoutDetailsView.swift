//
//  CreateWorkoutDetailsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutDetailsView: View {
    
    let exercise: ExerciseFromApi
    
    var body: some View {
        VStack(spacing: 10) {
            ExerciseImageView(imageUrl: exercise.image)
            
            Text(exercise.name)
                .font(.title)
            
            Text(exercise.description)
                .font(.subheadline)
            
            Spacer()
            
            Button("Add Exercise", action: {})
                .buttonStyle(.borderedProminent)
                .tint(.green)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    CreateWorkoutDetailsView(exercise: ExerciseFromApi.getExercise())
}
