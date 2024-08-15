//
//  ActiveWorkoutSingleView.swift
//  LegoFit
//
//  Created by Denis Denisov on 15/8/24.
//

import SwiftUI

struct ActiveWorkoutSingleView: View {
    let single: Exercise
    let completedApproach: Int
    
    var body: some View {
        VStack {
            LabelGradientBackground(content: Text(single.name))
                .font(.title)
            
            ExerciseImageView(imageUrl: single.image)
            
            Text("Sets: \(single.approach ?? 0) of \(completedApproach)")
            Text("Reps: \(single.rep ?? 0)")
            Text("Weight: \(single.weight ?? "0")")
            Text("Comment: \(single.comment ?? "")")
        }
    }
}

#Preview {
    ZStack {
        MainGradientBackground()
        VStack {
            ActiveWorkoutSingleView(single: Exercise.getExercises().first!, completedApproach: 3)
            Spacer()
        }
    }
}
