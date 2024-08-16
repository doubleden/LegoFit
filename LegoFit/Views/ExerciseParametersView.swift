//
//  ExerciseParametersView.swift
//  LegoFit
//
//  Created by Denis Denisov on 16/8/24.
//

import SwiftUI

struct ExerciseParametersView: View {
    let exercise: Exercise
    var spacing: CGFloat = 30
    var isPaddingForComment = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            Text("\(exercise.rep ?? 0) reps")
                .font(.system(size: 25))
                .foregroundStyle(.orange)
            Text("\(exercise.weight ?? "0") kg")
                .font(.system(size: 20))
                .foregroundStyle(.cyan)
            if exercise.comment != "" && exercise.comment != nil {
                VStack(alignment: .leading) {
                    Text("Comment:")
                        .font(.caption)
                    Text(exercise.comment ?? "no comment")
                        .padding(isPaddingForComment ? .leading : .Element())
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

#Preview {
    ExerciseParametersView(exercise: Exercise.getExercises().first!)
}
