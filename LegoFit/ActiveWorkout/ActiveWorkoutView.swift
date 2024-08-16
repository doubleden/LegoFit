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
    @Environment(\.dismiss) private var dismiss
    
    private var exercise: ExerciseType {
        activeWorkoutVM.currentExercise
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                MainGradientBackground()
                    .ignoresSafeArea()
                    .blur(radius: 3)
                if activeWorkoutVM.isExercisesCompleted || workout.isDone {
                    ActiveWorkoutFinishView(input: $activeWorkoutVM.workoutComment) {
                        workout.comment = activeWorkoutVM.workoutComment
                        workout.isDone.toggle()
                        dismiss()
                    }
                } else {
                    VStack(spacing: 20) {
                        
                        ProgressView(
                            value: Double(activeWorkoutVM.queue),
                            total: Double(workout.exercises.count)
                        )
                        .padding(EdgeInsets(top: 0, leading: -15, bottom: 0, trailing: -15))
                        .tint(.white)
                        
                        Group {
                            switch exercise {
                            case .single(let single):
                                ActiveWorkoutSingleView(
                                    single: single,
                                    completedApproach: activeWorkoutVM.completedApproach
                                )
                            case .lap(let lap):
                                ActiveWorkoutLapView(
                                    lap: lap,
                                    completedApproach: activeWorkoutVM.completedApproach
                                )
                            }
                        }
                        .transition(
                            .asymmetric(
                                insertion: .slide,
                                removal: AnyTransition.scale(scale: 0, anchor: .trailing)
                                    .combined(with: .slide)
                            )
                        )
                        .id(exercise)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.easeIn) {
                                activeWorkoutVM.didFinish()
                                activeWorkoutVM.doneWorkout()
                            }
                            activeWorkoutVM.setButtonTittle()
                        }, label: {
                            Text(activeWorkoutVM.buttonTitle)
                                .tint(.green)
                        })
                        
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
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
