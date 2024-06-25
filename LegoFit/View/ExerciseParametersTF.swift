//
//  ExerciseParametersTF.swift
//  LegoFit
//
//  Created by Denis Denisov on 26/6/24.
//

import SwiftUI

enum FocusedTextField {
    case sets
    case reps
    case weight
    case comment
}

struct ExerciseParametersTF: View {
    @Binding var sets: String
    @Binding var reps: String
    @Binding var weight: String
    @Binding var comment: String
    @FocusState var isFocused: FocusedTextField?
    
    var body: some View {
        VStack(spacing: 12) {
            ParameterTextFieldView(title: "Подход", text: "0", input: $sets)
                .focused($isFocused, equals: .sets)
            ParameterTextFieldView(title: "Раз", text: "0", input: $reps)
                .focused($isFocused, equals: .reps)
            ParameterTextFieldView(title: "Вес", text: "0", input: $weight)
                .focused($isFocused, equals: .weight)
            Spacer()
            TextField("коментарии", text: $comment)
                .focused($isFocused, equals: .comment)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
        }
    }
}

#Preview {
    ExerciseParametersTF(
        sets: .constant("2"),
        reps: .constant("15"),
        weight: .constant("150"),
        comment: .constant("С резинками")
    )
}
