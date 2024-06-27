//
//  MyWorkoutDetailsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 21/6/24.
//

import SwiftUI

struct MyWorkoutDetailsView: View {
    var exercise: Exercise
    
    @State var set = ""
    @State var rep = ""
    @State var weight = ""
    @State var comment = ""
    
    @Environment(\.dismiss) var dismis
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ExerciseParametersTF(
                    sets: $set,
                    reps: $rep,
                    weight: $weight,
                    comment: $comment
                )
                
                Button("Save") {
                    exercise.set = Int(set) ?? 0
                    exercise.rep = Int(rep) ?? 0
                    exercise.weight = Int(weight) ?? 0
                    exercise.comment = comment
                    dismis()
                }
                .buttonStyle(.borderedProminent)
            }
            .onAppear {
                set = exercise.set.formatted()
                rep = exercise.rep.formatted()
                weight = exercise.weight.formatted()
                comment = exercise.comment
            }
        .padding()
        }
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    let workouts = try? container.mainContext.fetch(FetchDescriptor<Workout>())
    let workout = workouts?.first ?? Workout.getWorkout()
    let exercise = workout.exercises.first
    
    return MyWorkoutDetailsView(exercise: exercise!)
}
