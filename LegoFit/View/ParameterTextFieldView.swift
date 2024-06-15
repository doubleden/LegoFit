//
//  ParameterTextFieldView.swift
//  LegoFit
//
//  Created by Denis Denisov on 15/6/24.
//

import SwiftUI

struct ParameterTextFieldView: View {
    let title: String
    let text: String
    @Binding var input: String
    
    var body: some View {
        HStack(spacing: 20) {
            
            Text(title)
                .font(.headline)
                .frame(width: 65, alignment: .leading)
            
            TextField(text, text: $input)
                .textFieldStyle(OvalTextFieldStyle())
                .frame(maxWidth: 100, alignment: .leading)
        }
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 0))
            .frame(alignment: .trailing)
            .background(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            .main,
                            .cellBackground
                        ]
                    ),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .keyboardType(.numberPad)
    }
}

#Preview {
    ParameterTextFieldView(title: "Set", text: "0", input: .constant("set"))
}
