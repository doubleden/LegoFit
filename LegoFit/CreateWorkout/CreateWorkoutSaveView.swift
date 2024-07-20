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
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 25) {
                InputNameTF(input: $createWorkoutVM.workout.name)
                
                SaveButton(isDisabled: !createWorkoutVM.isWorkoutNameValid()) {
                    createWorkoutVM.saveWorkout(
                        modelContext: modelContext
                    )
                    createWorkoutVM.cancelCreateWorkout(
                        modelContext: modelContext
                    )
                    dismiss()
                }
                
                Spacer()
            }
            .padding(.top, 40)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Clear") {
                        createWorkoutVM.cancelCreateWorkout(modelContext: modelContext)
                    }
                    .tint(.main)
                }
            }
        }
    }
}

private struct CustomButtonStyle: ButtonStyle {
    let isDisabled: Bool
    
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 300 ,height: 45)
            .background(isDisabled ? .offButton : .main)
            .clipShape(.rect(cornerRadius: 5))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct InputNameTF: View {
    @Binding var input: String
    
    var body: some View {
        TextField("Название тренировки", text: $input)
            .padding()
            .frame(width: 300, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.main)
            )
    }
}

struct SaveButton: View {
    let isDisabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text("Сохранить тренировку")
                .tint(.white)
        })
        .font(.title2)
        .buttonStyle(CustomButtonStyle(isDisabled: isDisabled))
        .disabled(isDisabled)
    }
}

#Preview {
    let container = DataController.previewContainer
    
    return CreateWorkoutSaveView(createWorkoutVM: CreateWorkoutViewModel())
        .modelContainer(container)
        
}
