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
    @State private var isPresented = false
    
    private var exercise: ExerciseType {
        activeWorkoutVM.currentExercise
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                MainBackgroundWithFlashAnimation(
                    activeWorkoutVM: activeWorkoutVM
                )
                if activeWorkoutVM.isExercisesDidEnd {
                    ActiveWorkoutFinishView(
                        input: $activeWorkoutVM.workoutComment
                    ) {
                        workout.comment = activeWorkoutVM.workoutComment
                        workout.finishDate = Date.now
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
                        .tint(.yellow)
                        
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
                                insertion: .move(edge: .trailing),
                                removal: .scale(scale: 0, anchor: .leading)
                                    .combined(with: .move(edge: .leading))
                            )
                        )
                        .id(exercise)
                        
                        Button(activeWorkoutVM.buttonTitle.localized) {
                            if activeWorkoutVM.buttonTitle == .finish {
                                withAnimation {
                                    activeWorkoutVM.isExercisesDidEnd.toggle()
                                }
                                return
                            }
                            startVibration()
                            withAnimation(.smooth) {
                                activeWorkoutVM.buttonDidTapped.toggle()
                                activeWorkoutVM.finishApproach()
                                DispatchQueue.main.asyncAfter(
                                    deadline: .now() + 0.4
                                ) {
                                    withAnimation(.smooth) {
                                        activeWorkoutVM.buttonDidTapped.toggle()
                                        activeWorkoutVM.setButtonTittle()
                                    }
                                }
                            }
                        }
                        .buttonStyle(
                            CustomButtonStyle(
                                buttonTitle: activeWorkoutVM.buttonTitle
                            )
                        )
                        
                        Spacer()
                    }
                }
            }
            .sheet(isPresented: $isPresented, content: {
                CurrentWorkoutListView(
                    workout: activeWorkoutVM.workout,
                    currentExercise: activeWorkoutVM.currentExercise
                )
                .presentationDragIndicator(.visible)
                .background(MainGradientBackground().blur(radius: 50))
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isPresented.toggle()
                    },label: {
                        Image(systemName: "info.circle")
                    })
                }
            }
        }
    }
    
    init(workout: Workout) {
        self.workout = workout
        self.activeWorkoutVM = ActiveWorkoutViewModel(workout: workout)
    }
}

fileprivate struct CustomButtonStyle: ButtonStyle {
    let buttonTitle: ButtonTitle
    
    private var color: RadialGradient {
        switch buttonTitle {
        case .done:
            RadialGradient(colors: [.orange, .darkGrey, .black], center: .center, startRadius: 60, endRadius: 5)
        case .next:
            RadialGradient(colors: [.purple, .darkGrey, .black], center: .center, startRadius: 60, endRadius: 5)
        case .finish:
            RadialGradient(colors: [.yellow, .darkGrey, .black], center: .center, startRadius: 60, endRadius: 5)
        }
    }
    
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 150, height: 80)
            .padding()
            .font(.title3)
            .background(color)
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.7 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .shadow(radius: configuration.isPressed ? 30 : 15)
    }
}

struct MainBackgroundWithFlashAnimation: View {
    @Bindable var activeWorkoutVM: ActiveWorkoutViewModel
    
    private var flashColor: Color {
        switch activeWorkoutVM.buttonTitle {
        case .done: .orange
        case .next: .violet
        case .finish: .clear
        }
    }
    
    var body: some View {
        MainGradientBackground()
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(
                        flashColor.opacity(0.8),
                        lineWidth: activeWorkoutVM.buttonDidTapped ? 30 : 0
                    )
                    .shadow(
                        color: flashColor.opacity(0.8),
                        radius: activeWorkoutVM.buttonDidTapped ? 10 : 0
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )
            )
            .ignoresSafeArea()
            .blur(radius: 3)
    }
}

#Preview {
    let container = DataController.previewContainer
    
    return ActiveWorkoutView(workout: Workout.getWorkout())
        .modelContainer(container)
}
