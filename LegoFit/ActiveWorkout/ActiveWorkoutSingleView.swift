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
                .frame(width: 150, height: 150)
            
            ParametersView(single: single, completedApproach: completedApproach)
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

fileprivate struct ParametersView: View {
    let single: Exercise
    let completedApproach: Int
    
    var body: some View {
        HStack(spacing: 25) {
            VStack(alignment: .trailing) {
                Text("sets done")
                Text("\(completedApproach) of \(single.approach ?? 0)")
                    .font(.system(size: 50))
                    .frame(minWidth: 150, alignment: .trailing)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Rectangle()
                .frame(width: 2, height: 200)
                .foregroundStyle(.sky)
            VStack(alignment: .leading, spacing: 30) {
                Text("\(single.rep ?? 0) reps")
                    .font(.system(size: 25))
                Text("\(single.weight ?? "") kg")
                    .font(.system(size: 20))
                if single.comment != "" {
                    VStack(alignment: .leading) {
                        Text("Comment:")
                            .font(.caption)
                        Text(single.comment ?? "no comment")
                            .padding(.leading)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
        .padding()
        .background(clearGray)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
