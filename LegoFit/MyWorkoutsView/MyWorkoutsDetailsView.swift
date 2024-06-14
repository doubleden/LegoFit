//
//  MyWorkoutsDitaisView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/6/24.
//

import SwiftUI

struct MyWorkoutsDetailsView: View {
    let workout: Workout
    
    private var sortedExercise: [Exercise] {
        workout.exercises.sorted { $0.queue < $1.queue}
    }
    
    var body: some View {
        Text(workout.name)
        List(sortedExercise, id: \.id) { exercise in
            VStack(alignment: .leading, spacing: 10) {
                Text(exercise.name)
                Text(exercise.set.formatted())
                Text(exercise.rep.formatted())
                Text(exercise.weight.formatted())
            }
        }
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    let workouts = try? container.mainContext.fetch(FetchDescriptor<Workout>())
    let workout = workouts?.first ?? Workout.getWorkout()

    return MyWorkoutsDetailsView(workout: workout)
        .modelContainer(container)
}
