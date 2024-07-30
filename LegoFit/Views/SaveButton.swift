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
        Button("Save") {
            action()
        }
        .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
        .background(.main)
        .tint(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SaveButton(action: {})
}
