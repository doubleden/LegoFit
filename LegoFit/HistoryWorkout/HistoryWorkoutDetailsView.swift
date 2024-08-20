//
//  HistoryWorkoutDetailsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 20/8/24.
//

import SwiftUI

struct HistoryWorkoutDetailsView: View {
    let workout: Workout
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(workout.finishDate.showDate())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                if !workout.comment.isEmpty {
                    VStack {
                        Text(workout.comment)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.cosmos.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke())
                    }
                    .padding()
                }
                
                VStack(spacing: 0) {
                    DividerHorizontalView()
                    
                    List(workout.exercises) { exerciseType in
                        switch exerciseType {
                        case .single(let exercise):
                            ExerciseCellView(exercise: exercise)
                                .mainRowStyle()
                        case .lap(let lap):
                            DisclosureGroup("Lap: \(lap.approach)") {
                                ForEach(lap.exercises) { exercise in
                                    ExerciseCellView(exercise: exercise, isInLap: true)
                                        .lapExerciseRowStyle()
                                }
                            }
                            .tint(.white)
                            .mainRowStyle()
                        }
                    }
                    .mainListStyle()
                }
            }
            .background(MainGradientBackground())
            .navigationTitle("\(workout.name)")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        startVibrationSuccess()
                        copyWorkout()
                        dismiss()
                    }, label: {
                        Image(systemName: "gobackward")
                    })
                }
            }
        }
    }
    
    private func copyWorkout() {
        let copiedWorkout = Workout()
        copiedWorkout.name = "Copy of \(workout.name)"
        copiedWorkout.exercises = workout.exercises
        StorageManager.shared.save(workout: copiedWorkout, context: modelContext)
    }
}

#Preview {
    let container = DataController.previewContainer
    
    return HistoryWorkoutDetailsView(workout: Workout.getWorkout())
        .modelContainer(container)
}
