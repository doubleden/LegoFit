//
//  MyWorkoutsDitaisView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/6/24.
//

import SwiftUI

struct MyWorkoutsDetailsView: View {
    let workout: Workout
    
    var body: some View {
        List(workout.exercises, id: \.id) { exercise in
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
