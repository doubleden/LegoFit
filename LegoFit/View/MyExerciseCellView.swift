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
                    Text("\(exercise.set) / \(exercise.rep) / \(exercise.weight)")
                }
                .tint(.white)
            }
        }
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    let workouts = try? container.mainContext.fetch(FetchDescriptor<Workout>())
    let workout = workouts?.first ?? Workout.getWorkout()

    return MyExerciseCellView(exercise: workout.exercises.first!, action: {})
        .modelContainer(container)
}
