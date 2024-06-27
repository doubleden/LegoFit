//
//  CreateWorkoutSaveView.swift
//  LegoFit
//
//  Created by Denis Denisov on 11/6/24.
//

import SwiftUI

struct CreateWorkoutSaveView: View {
    @Binding var workoutTitle: String
    let isInputValid: Bool
    let action: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.isEnabled) var isEnabled
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            TextField("Название тренировки", text: $workoutTitle)
                .padding()
                .frame(width: 300, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.main)
                )
            
            Button(action: {
                action()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    dismiss()
                }
                
            }, label: {
                Text("Сохранить тренировку")
                    .tint(.white)
            })
            .font(.title2)
            .buttonStyle(CustomButtonStyle(isDisabled: !isInputValid))
            .disabled(!isInputValid)
            Spacer()
        }
        .padding(.top, 40)
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

#Preview {
    CreateWorkoutSaveView(workoutTitle: .constant("New Workout"), isInputValid: false, action: {})
}
