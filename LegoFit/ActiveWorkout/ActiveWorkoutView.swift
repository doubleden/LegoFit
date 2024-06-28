//
//  ActiveWorkoutView.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import SwiftUI

struct ActiveWorkoutView: View {
    @Bindable var activeWorkoutVM: ActiveWorkoutViewModel
    @Environment(\.dismiss) private var dismiss
    private var exercise: Exercise {
        activeWorkoutVM.exercise
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(exercise.name)
                .font(.largeTitle)
            
            ExerciseImageView(imageUrl: exercise.photo)
            
            Text(
                "Подходов сделано: \(activeWorkoutVM.completedSets) из \(exercise.set)"
            )
            
            VStack(alignment: .leading) {
                Text("Повторения: \(exercise.rep)")
                Text("Вес: \(exercise.weight)")
            }
            
            Text(exercise.comment)
            
            Button(activeWorkoutVM.isLastExercise
                   ? "Закончить"
                   : "Далее") {
                withAnimation(.easeInOut(duration: 0.8)) {
                    activeWorkoutVM.showNextExercise()
                }
                activeWorkoutVM.finishWorkout {
                    dismiss()
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    let workouts = try? container.mainContext.fetch(FetchDescriptor<Workout>())
    let workout = workouts?.first ?? Workout.getWorkout()

    return ActiveWorkoutView(activeWorkoutVM: ActiveWorkoutViewModel(workout: workout))
        .modelContainer(container)
}
