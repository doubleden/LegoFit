//
//  CellTextView.swift
//  LegoFit
//
//  Created by Denis Denisov on 21/7/24.
//

import SwiftUI

struct CellTextView: View {
    let exercise: Exercise
    var isLap = false
    
    var body: some View {
        HStack {
            Text("\(exercise.name)   (")
            if !isLap {
                Text("\(exercise.approach ?? 0)  /")
            }
            Text("\(exercise.rep ?? 0)  /")
            Text("\(exercise.weight ?? 0)  )")
        }
    }
}

#Preview {
    CellTextView(exercise: Exercise.getExercises().first!)
}
