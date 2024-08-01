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
            VStack(alignment: .leading) {
                if !isAddingLaps {
                    ParameterTFView(title: "Sets", placeholder: "0", input: $sets)
                        .focused($isFocused, equals: .sets)
                }
                ParameterTFView(title: "Reps", placeholder: "0", input: $reps)
                    .focused($isFocused, equals: .reps)
                ParameterTFView(title: "Weight", placeholder: "0", isWeight: true, input: $weight)
                    .focused($isFocused, equals: .weight)
                    .padding(.bottom, 20)
            }
            
            TextField("Comment", text: $comment)
                .focused($isFocused, equals: .comment)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
        }
        .onChange(of: isFocused, { _, _ in
            if !isValid(weight: weight) {
                weight = ""
            }
        })
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack(spacing: 20) {
                    Spacer()
                    if isFocused == .weight {
                        Button(action: {
                            weight += " + "
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
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
    
    private func isValid(weight: String) -> Bool {
        let pattern = #"^\d+(\s*\+\s*\d+)?$"#
        let regex = try! NSRegularExpression(
            pattern: pattern,
            options: []
        )
        
        let range = NSRange(location: 0, length: weight.utf16.count)
        return regex.firstMatch(in: weight, options: [], range: range) != nil
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
