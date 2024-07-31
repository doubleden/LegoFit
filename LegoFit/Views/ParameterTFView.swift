//
//  ParameterTextFieldView.swift
//  LegoFit
//
//  Created by Denis Denisov on 15/6/24.
//

import SwiftUI

struct ParameterTFView: View {
    let title: String
    let placeholder: String
    @Binding var input: String
    
    var body: some View {
        HStack(spacing: 10) {
            Text(title)
                .font(.headline)
                .frame(width: 65, alignment: .leading)
            
            TextField(placeholder, text: $input)
                .textFieldStyle(OvalTextFieldStyle())
                .frame(maxWidth: 100, alignment: .leading)
        }
    }
}

#Preview {
    ParameterTFView(title: "Set", placeholder: "0", input: .constant("set"))
}
