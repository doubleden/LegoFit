//
//  CellTextView.swift
//  LegoFit
//
//  Created by Denis Denisov on 21/7/24.
//

import SwiftUI

struct CellTextView: View {
    let exercise: Exercise
    
    var body: some View {
        Text("\(exercise.name) | (\(exercise.approach ?? 0) / \(exercise.rep ?? 0) / \(exercise.weight ?? 0))")
    }
}

#Preview {
    CellTextView(exercise: Exercise.getExercises().first!)
}
