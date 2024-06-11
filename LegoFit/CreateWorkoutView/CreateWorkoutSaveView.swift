//
//  CreateWorkoutSaveView.swift
//  LegoFit
//
//  Created by Denis Denisov on 11/6/24.
//

import SwiftUI

struct CreateWorkoutSaveView: View {
    @Binding var workoutTitle: String
    let saveAction: () -> Void
    @Environment(\.dismiss) var dismiss
    @State private var isPressed = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            TextField("Название тренировки", text: $workoutTitle)
                .textFieldStyle(.roundedBorder)
                .frame(width: 300, height: 30)
            
            Button(action: {
                saveAction()
                dismiss()
            }, label: {
                Text("Сохранить тренировку")
                    .tint(.white)
            })
            .font(.title2)
            .frame(width: 300 ,height: 45)
            .background(.green)
            .clipShape(.rect(cornerRadius: 10))
            
            Spacer()
        }
        .padding(.top, 40)
    }
}

#Preview {
    CreateWorkoutSaveView(workoutTitle: .constant("New Workout"), saveAction: {})
}
