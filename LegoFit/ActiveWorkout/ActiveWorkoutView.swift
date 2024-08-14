//
//  ActiveWorkoutView.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import SwiftUI

struct ActiveWorkoutView: View {
    var workout: Workout
    @State private var activeWorkoutVM: ActiveWorkoutViewModel
    
    private var exercise: ExerciseType {
        activeWorkoutVM.currentExercise
    }
    
    var body: some View {
        ZStack {
            MainGradientBackground()
                .ignoresSafeArea()
                .blur(radius: 3)
            VStack(spacing: 20) {
                Text("\(activeWorkoutVM.queue) of \(workout.exercises.count)")
                
                ProgressView(
                    value: Double(activeWorkoutVM.queue),
                    total: Double(workout.exercises.count)
                )
                
                switch exercise {
                case .single(let single):
                    LabelGradientBackground(content: Text(single.name))
                        .font(.title)
                    
                    ExerciseImageView(imageUrl: single.image)
                    
                    Text("Sets: \(single.approach ?? 0) of \(activeWorkoutVM.doneApproach)")
                    Text("Reps: \(single.rep ?? 0)")
                    Text("Weight: \(single.weight ?? "0")")
                    Text("Comment: \(single.comment ?? "")")
                    
                case .lap(let lap):
                    Text("Quantity: \(lap.quantity) of \(activeWorkoutVM.doneApproach)")
                    List(lap.exercises) { exercise in
                        HStack {
                            ExerciseImageView(imageUrl: exercise.image)
                                .frame(width: 120)
                            Spacer()
                            VStack(alignment: .leading) {
                                Text(exercise.name)
                                Text("\(exercise.rep ?? 0) reps")
                                Text("\(exercise.weight ?? "0") kg")
                            }
                        }
                            .mainRowStyle()
                    }
                    .mainListStyle()
                }
                
                Button(action: {}, label: {
                    Text("Done Set")
                        .tint(.green)
                })
                
                Spacer()
            }
            .padding()
        }
    }
    
    init(workout: Workout) {
        self.workout = workout
        self.activeWorkoutVM = ActiveWorkoutViewModel(workout: workout)
    }
}

#Preview {
    let container = DataController.previewContainer

    return ActiveWorkoutView(workout: Workout.getWorkout())
        .modelContainer(container)
}
