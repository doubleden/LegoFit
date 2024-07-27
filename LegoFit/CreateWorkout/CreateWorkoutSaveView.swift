//
//  CreateWorkoutSaveView.swift
//  LegoFit
//
//  Created by Denis Denisov on 11/6/24.
//

import SwiftUI

struct CreateWorkoutSaveView: View {
    @Bindable var createWorkoutVM: CreateWorkoutViewModel
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @FocusState private var isFocused
    
    var body: some View {
        NavigationStack {
            ZStack {
                MainGradientBackground()
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 25) {
                    InputNameTF(
                        input: $createWorkoutVM.workout.name,
                        isFocused: $isFocused
                    )
                    
                    SaveButton(isDisabled: !createWorkoutVM.isWorkoutNameValid()) {
                        createWorkoutVM.saveWorkout(
                            modelContext: modelContext
                        )
                        createWorkoutVM.cancelCreateWorkout(
                            modelContext: modelContext
                        )
                        dismiss()
                    }
                    .padding(.bottom)
                    
                    ExerciseList(
                        exercises: createWorkoutVM.workout.exercises
                    ) { single in
                        createWorkoutVM.deleteExercise(
                            withQueue: single.queue ?? 0
                        )
                        } actionForLap: { lap in
                            createWorkoutVM.deleteExercise(
                                withQueue: lap.queue
                            )
                        }
                }
                .padding(.top, 20)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Clear") {
                            createWorkoutVM.cancelCreateWorkout(modelContext: modelContext)
                        }
                        .tint(.main)
                    }
                }
            }
            .onTapGesture {
                isFocused = false
            }
        }
    }
}

fileprivate struct InputNameTF: View {
    @Binding var input: String
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        TextField("Name of workout", text: $input)
            .padding()
            .frame(width: 300, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.main)
            )
            .focused($isFocused)
    }
}

fileprivate struct SaveButton: View {
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text("Create")
                .tint(.white)
        })
        .font(.title2)
        .buttonStyle(CustomButtonStyle(isDisabled: isDisabled))
        .disabled(isDisabled)
    }
}

private struct CustomButtonStyle: ButtonStyle {
    let isDisabled: Bool
    
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 150 ,height: 50)
            .background(isDisabled ? .offButton : .main)
            .clipShape(.rect(cornerRadius: 5))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

fileprivate struct ExerciseList: View {
    let exercises: [ExerciseType]
    let actionForSingle: (Exercise) -> Void
    let actionForLap: (Lap) -> Void
    
    var body: some View {
        VStack(spacing: 1) {
            Divider()
            List {
                ForEach(exercises) { exerciseType in
                    switch exerciseType {
                    case .single(let single):
                        HStack {
                            Text(single.name)
                            Spacer()
                            DeleteButton {
                                actionForSingle(single)
                            }
                        }
                        .mainRowStyle()
                        
                    case .lap(let lap):
                        Section {
                            ForEach(lap.exercises) { exercise in
                                Text(exercise.name)
                                    .mainRowStyle()
                            }
                        } header: {
                            HStack {
                                Text("Lap: \(lap.quantity)")
                                    .font(.headline)
                                Spacer()
                                DeleteButton {
                                    actionForLap(lap)
                                }
                            }
                        }
                    }
                }
            }
            .mainListStyle()
        }
    }
}

fileprivate struct DeleteButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation(.spring) {
                action()
            }
        }, label: {
            Image(systemName: "minus.circle")
        })
    }
}

#Preview {
    let container = DataController.previewContainer
    let createWorkoutVM = CreateWorkoutViewModel()
    let exercises = Exercise.getExercises()
    let laps = Lap.getLaps()
    createWorkoutVM.exercisesInLaps.append(contentsOf: exercises)
    for i in 0..<exercises.count {
        let exercise = exercises[i]
        createWorkoutVM.add(exercise: exercise)
    }
    
    for _ in 0..<laps.count {
        createWorkoutVM.addToWorkoutLap()
    }
    
    return CreateWorkoutSaveView(createWorkoutVM: createWorkoutVM)
        .modelContainer(container)
        
}
