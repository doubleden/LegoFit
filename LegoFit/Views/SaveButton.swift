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
        Button("Save", action: action)
            .foregroundStyle(.green)
    }
}

#Preview {
    SaveButton(action: {})
}
