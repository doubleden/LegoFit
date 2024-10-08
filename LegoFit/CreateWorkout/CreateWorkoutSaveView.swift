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
                    .onTapGesture {
                        isFocused = false
                    }
                
                VStack(alignment: .center, spacing: 25) {
                    InputNameTF(
                        input: $createWorkoutVM.workout.name,
                        isFocused: $isFocused
                    )
                    
                    SaveWorkoutButton(isDisabled: !createWorkoutVM.isCreateButtonDisabled) {
                        createWorkoutVM.saveWorkout(
                            modelContext: modelContext
                        )
                        createWorkoutVM.cancelCreateWorkout()
                        dismiss()
                    }
                    .padding(.bottom)
                    
                    ExerciseList(exercises: createWorkoutVM.workout.exercises) { indexSet in
                        createWorkoutVM.deleteCell(indexSet)
                    } deleteCellLap: { lap in
                        createWorkoutVM.delete(lap: lap)
                    } deleteCellInLap: { lap, indexSet in
                        createWorkoutVM.delete(inLap: lap, exerciseWith: indexSet)
                    }
                }
                .padding(.top, 20)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Clear") {
                            createWorkoutVM.cancelCreateWorkout()
                        }
                        .tint(.white)
                    }
                }
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
                    .stroke(Color.yellow)
            )
            .autocorrectionDisabled()
            .focused($isFocused)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            isFocused.toggle()
                        }
                    }
                }
            }
    }
}

fileprivate struct SaveWorkoutButton: View {
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            startVibrationSuccess()
            action()
        }, label: {
            Text("Create")
                .tint(.white)
        })
        .font(.title2)
        .buttonStyle(CustomButtonStyle(isDisabled: isDisabled))
        .disabled(isDisabled)
    }
}

fileprivate struct CustomButtonStyle: ButtonStyle {
    let isDisabled: Bool
    
    let off = Gradient(colors: [.offButton.opacity(0.3)])
    let on = Gradient(colors: [clearGray, .violet])
    
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 150 ,height: 50)
            .foregroundStyle(isDisabled ? .gray : .white)
            .background(isDisabled ? off : on)
            .clipShape(.rect(cornerRadius: 15))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

fileprivate struct ExerciseList: View {
    let exercises: [ExerciseType]
    let deleteCell: (IndexSet) -> Void
    let deleteCellLap: (Lap) -> Void
    let deleteCellInLap: (Lap, IndexSet) -> Void
    
    var body: some View {
        VStack(spacing: 1) {
            DividerHorizontalView()
            List {
                ForEach(exercises) { exerciseType in
                    switch exerciseType {
                    case .single(let single):
                        Text(single.name)
                            .mainRowStyle()
                        
                    case .lap(let lap):
                        Section {
                            ForEach(lap.exercises) { exercise in
                                Text(exercise.name)
                                    .mainRowStyle()
                            }
                            .onDelete(perform: { indexSet in
                                deleteCellInLap(lap, indexSet)
                            })
                        } header: {
                            HStack {
                                Text("Lap: \(lap.approach)")
                                    .font(.headline)
                                Spacer()
                                DeleteButton {
                                    deleteCellLap(lap)
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    deleteCell(indexSet)
                })
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
                .tint(.red)
        })
    }
}

#Preview {
    let container = DataController.previewContainer
    let createWorkoutVM = CreateWorkoutViewModel()
    createWorkoutVM.workout = Workout.getWorkout()
    return CreateWorkoutSaveView(createWorkoutVM: createWorkoutVM)
        .modelContainer(container)
        
}
