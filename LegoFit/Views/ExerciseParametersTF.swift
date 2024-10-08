//
//  ExerciseParametersTF.swift
//  LegoFit
//
//  Created by Denis Denisov on 26/6/24.
//

import SwiftUI

enum FocusedTextField {
    case approach
    case repetition
    case weight
    case comment
}

struct ExerciseParametersTF: View {
    @FocusState.Binding var isFocused: FocusedTextField?
    @Binding var approach: String
    @Binding var repetition: String
    @Binding var weight: String
    @Binding var comment: String
    var isAddingLaps = false
    
    private var localizeApproach: String {
        localize(russian: "Подход", english: "Sets")
    }
    
    private var localizeRepetition: String {
        localize(russian: "Раз", english: "Reps")
    }
    
    private var localizeWeight: String {
        localize(russian: "Вес", english: "Weight")
    }
    
    private var localizeComment: String {
        localize(russian: "Заметка", english: "Comment")
    }
    
    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading) {
                if !isAddingLaps {
                    ParameterTFView(title: localizeApproach, placeholder: "0", input: $approach)
                        .focused($isFocused, equals: .approach)
                }
                ParameterTFView(title: localizeRepetition, placeholder: "0", input: $repetition)
                    .focused($isFocused, equals: .repetition)
                ParameterTFView(title: localizeWeight, placeholder: "0", isWeight: true, input: $weight)
                    .focused($isFocused, equals: .weight)
                    .padding(.bottom, 20)
            }
            
            TextField(localizeComment, text: $comment)
                .focused($isFocused, equals: .comment)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                .frame(width: 310)
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack(spacing: 20) {
                    Button("Clear") {
                        clearFocusedTextField()
                    }
                    Spacer()
                    if isFocused == .weight {
                        Button(action: {
                            weight += " + \(weight)"
                        }, label: {
                            Image(systemName: "dumbbell")
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
        .onChange(of: isFocused, { _, _ in
            if !isValid(weight: weight) {
                weight = ""
            }
        })
        .onChange(of: isFocused, { _, _ in
            switch isFocused {
            case .approach:
                if approach == "0" {
                    approach = ""
                }
            case .repetition:
                if repetition == "0" {
                    repetition = ""
                }
            case .weight:
                if weight == "0" {
                    weight = ""
                }
            case .comment:
                if comment == "0" {
                    comment = ""
                }
            case nil:
                return
            }
        })
    }
    
    private func clearFocusedTextField() {
        switch isFocused {
        case .approach:
            approach = ""
        case .repetition:
            repetition = ""
        case .weight:
            weight = ""
        case .comment:
            comment = ""
        case nil:
            return
        }
    }
    
    private func changeIsFocused() {
        switch isFocused {
        case .approach:
            isFocused = .repetition
        case .repetition:
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
        isFocused: $focusedField, approach: .constant("2"),
        repetition: .constant("15"),
        weight: .constant("150"),
        comment: .constant("С резинками"), isAddingLaps: false
    )
}
