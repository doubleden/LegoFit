//
//  CurrentWorkoutListView.swift
//  LegoFit
//
//  Created by Denis Denisov on 19/8/24.
//

import SwiftUI

struct CurrentWorkoutListView: View {
    let workout: Workout
    let currentExercise: ExerciseType
    
    var body: some View {
        VStack {
            Text("Exercise list")
                .font(.title)
            
            List(workout.exercises) { exerciseType in
                switch exerciseType {
                case .single(let exercise):
                    ExerciseCellView(exercise: exercise)
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(.gray)
                                .opacity(0.3)
                                .strokeStyle(isCurrentExercise: isCurrentExercise(exerciseType))
                        )
                case .lap(let lap):
                    DisclosureGroup("Lap: \(lap.approach)") {
                        ForEach(lap.exercises) { exercise in
                            ExerciseCellView(exercise: exercise, isInLap: true)
                            .lapExerciseRowStyle()
                        }
                    }
                    .tint(.white)
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.gray)
                            .opacity(0.3)
                            .strokeStyle(isCurrentExercise: isCurrentExercise(exerciseType))
                    )
                }
            }
            .mainListStyle()
        }
        .padding(.top, 40)
    }
    
    private func isCurrentExercise(_ exerciseType: ExerciseType) -> Bool {
        exerciseType.id == currentExercise.id
    }
}

extension View {
    func strokeStyle(isCurrentExercise: Bool) -> some View {
        modifier(Stroke(isCurrentExercise: isCurrentExercise))
    }
}

fileprivate struct Stroke: ViewModifier {
    let isCurrentExercise: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if isCurrentExercise {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 4)
                            .foregroundStyle(.yellow)
                    } else {
                        Circle()
                            .foregroundStyle(.clear)
                    }
                }
            )
    }
}

#Preview {
    let container = DataController.previewContainer
    let workout = Workout.getWorkout()
    let exercise = workout.exercises.first!
    return CurrentWorkoutListView(workout: workout, currentExercise: exercise)
        .modelContainer(container)
        .background(MainGradientBackground())
}
