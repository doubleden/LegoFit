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
    var isAddingLaps = false
    
    @FocusState.Binding var isFocused: FocusedTextField?
    
    var body: some View {
        VStack(spacing: 12) {
            if !isAddingLaps {
                ParameterTextFieldView(title: "Sets", text: "0", input: $sets)
                    .focused($isFocused, equals: .sets)
            }
            ParameterTextFieldView(title: "Reps", text: "0", input: $reps)
                .focused($isFocused, equals: .reps)
            ParameterTextFieldView(title: "Weight", text: "0", input: $weight)
                .focused($isFocused, equals: .weight)
                .padding(.bottom, 20)
            TextField("Comment", text: $comment)
                .focused($isFocused, equals: .comment)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button(
                        isFocused == .comment
                        ? "Done"
                        : "Next"
                    ) {
                        changeIsFocused()
                    }
                }
            }
        }
    }
    
    private func changeIsFocused() {
        switch isFocused {
        case .sets:
            isFocused = .reps
        case .reps:
            isFocused = .weight
        case .weight:
            isFocused = .comment
        default:
            isFocused = nil
        }
    }
}

#Preview {
    @FocusState var focusedField: FocusedTextField?
    return ExerciseParametersTF(
        sets: .constant("2"),
        reps: .constant("15"),
        weight: .constant("150"),
        comment: .constant("С резинками"), isAddingLaps: false, isFocused: $focusedField
    )
}
