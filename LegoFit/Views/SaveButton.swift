//
//  SaveButton.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/7/24.
//

import SwiftUI

struct SaveButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text("Save")
                .foregroundStyle(.white)
                .padding(.trailing, 6)
        })
        .background(Gradient(colors: [.gray.opacity(mainOpacity), .venom]))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SaveButton(action: {})
}
