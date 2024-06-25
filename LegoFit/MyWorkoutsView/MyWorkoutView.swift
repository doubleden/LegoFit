//
//  MyWorkoutsDitaisView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/6/24.
//

import SwiftUI

struct MyWorkoutView: View {
    let workout: Workout
    
    private var sortedExercise: [Exercise] {
        workout.exercises.sorted { $0.queue < $1.queue}
    }
    
    var body: some View {
        NavigationStack {
            List(sortedExercise) { exercise in
                NavigationLink(exercise.name, destination: MyWorkoutDetailsView())
            }
            .navigationTitle(workout.name)
        }
    }
}


import SwiftData
#Preview {
    let container = DataController.previewContainer
    let workouts = try? container.mainContext.fetch(FetchDescriptor<Workout>())
    let workout = workouts?.first ?? Workout.getWorkout()

    return MyWorkoutView(workout: workout)
        .modelContainer(container)
}
