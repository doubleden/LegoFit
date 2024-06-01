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
    
    //TODO: Нужно сделать сохранение в базу данных
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    CreateWorkoutDetailsView(exercise: ExerciseFromApi.getExercise())
}
