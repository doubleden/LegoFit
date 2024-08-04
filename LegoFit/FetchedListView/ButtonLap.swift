//
//  ButtonLap.swift
//  LegoFit
//
//  Created by Denis Denisov on 3/8/24.
//

import SwiftUI

struct ButtonLap: View {
    @Binding var isAddingLap: Bool
    var body: some View {
        Button(action: {
            withAnimation(.smooth) {
                isAddingLap.toggle()
            }
        }, label: {
            Image(systemName: isAddingLap ? "figure.run.square.stack.fill" : "figure.run.square.stack")
                .tint(.main)
        })
    }
}

#Preview {
    ButtonLap(isAddingLap: .constant(true))
}
