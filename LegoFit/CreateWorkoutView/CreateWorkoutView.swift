//
//  CreateWorkoutView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutView: View {
    
    let createWorkoutVM = CreateWorkoutViewViewModel()
    
    var body: some View {
        NavigationStack {
            List(createWorkoutVM.exercises) { exercise in
                Text(exercise.name)
            }
        }
        .onAppear {
            createWorkoutVM.fetchExercises()
        }
    }
}

#Preview {
    CreateWorkoutView()
}
