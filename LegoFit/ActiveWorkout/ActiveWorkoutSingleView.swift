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
        VStack(spacing: 30) {
            LabelGradientBackground(content: Text(single.name))
                .font(.title)
            
            ExerciseImageView(imageUrl: single.image)
                .frame(width: 250, height: 150)
            
            HStack(spacing: 25) {
                ApproachView(
                    text: "sets done",
                    completedApproach: completedApproach,
                    approach: single.approach ?? 0
                )
                
                DividerVerticalView()
                
                ExerciseParametersView(exercise: single)
            }
            .padding()
            .background(clearGray)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    ZStack {
        MainGradientBackground()
        VStack {
            ActiveWorkoutSingleView(single: Exercise.getExercises().first!, completedApproach: 1)
            Spacer()
            Button("Done", action: {})
        }
    }
}
