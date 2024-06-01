//
//  CreateWorkoutDetailsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutDetailsView: View {
    
    @Environment(\.modelContext) private var modelContext
    let exercise: ExerciseFromApi
    
    var body: some View {
        VStack {
            Text(" ")
        }
    }
}

#Preview {
    CreateWorkoutDetailsView(exercise: ExerciseFromApi.getExercise())
}
