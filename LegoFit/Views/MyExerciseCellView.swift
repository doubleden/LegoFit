//
//  MyExerciseCellView.swift
//  LegoFit
//
//  Created by Denis Denisov on 4/7/24.
//

import SwiftUI

struct MyExerciseCellView: View {
    let exercise: Exercise
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 40) {
                Text(exercise.name)
                    .tint(.white)
                Spacer()
                HStack(spacing: 5) {
                    CellTextView(exercise: exercise)
                }
                .tint(.white)
            }
        }
    }
}

#Preview {
    let exercise = Exercise.getExercises().first!
    return MyExerciseCellView(exercise: exercise, action: {})
}
