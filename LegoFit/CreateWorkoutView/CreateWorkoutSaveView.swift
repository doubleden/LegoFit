//
//  CreateWorkoutSaveView.swift
//  LegoFit
//
//  Created by Denis Denisov on 11/6/24.
//

import SwiftUI

struct CreateWorkoutSaveView: View {
    @Binding var workoutTitle: String
    let action: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.isEnabled) var isEnabled
    @State private var isPressed = false
    
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
                dismiss()
            }, label: {
                Text("Сохранить тренировку")
                    .tint(.white)
            })
            .font(.title2)
            .buttonStyle(CustomButtonStyle())
            
            Spacer()
        }
        .padding(.top, 40)
    }
}

private struct CustomButtonStyle: ButtonStyle {

    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        let background = configuration.isPressed ? Color.black : Color.main

        configuration.label
            .frame(width: 300 ,height: 45)
            .background(background)
            .clipShape(.rect(cornerRadius: 5))
    }
}

#Preview {
    CreateWorkoutSaveView(workoutTitle: .constant("New Workout"), action: {})
}
