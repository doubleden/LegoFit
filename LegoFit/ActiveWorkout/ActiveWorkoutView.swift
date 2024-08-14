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
        ZStack {
            MainGradientBackground()
                .ignoresSafeArea()
                .blur(radius: 3)
            if activeWorkoutVM.isExercisesCompleted || workout.isDone {
                VStack {
                    Text("Congratulations you did it!")
                    Button("Exit") {
                        workout.isDone.toggle()
                        dismiss()
                    }
                }
            } else {
                VStack(spacing: 20) {
                    Text("\(activeWorkoutVM.queue) of \(workout.exercises.count)")
                    
                    ProgressView(
                        value: Double(activeWorkoutVM.queue),
                        total: Double(workout.exercises.count)
                    )
                    .tint(.white)
                    
                    Group {
                        switch exercise {
                        case .single(let single):
                            VStack {
                                LabelGradientBackground(content: Text(single.name))
                                    .font(.title)
                                
                                ExerciseImageView(imageUrl: single.image)
                                
                                Text("Sets: \(single.approach ?? 0) of \(activeWorkoutVM.completedApproach)")
                                Text("Reps: \(single.rep ?? 0)")
                                Text("Weight: \(single.weight ?? "0")")
                                Text("Comment: \(single.comment ?? "")")
                            }
                        case .lap(let lap):
                            VStack {
                                Text("Quantity: \(lap.approach) of \(activeWorkoutVM.completedApproach)")
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
                .padding()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden()
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
