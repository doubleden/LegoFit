//
//  EditLapView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/7/24.
//

import SwiftUI

struct EditLapView: View {
    @Binding var lap: Lap
    
    @State private var textInput = ""
    
    var body: some View {
        ZStack {
            MainGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                Text("Quantity")
                ParameterTextFieldView(
                    title: "Lap",
                    text: lap.quantity.formatted(),
                    input: $textInput
                )
            }
            .onDisappear {
                if !textInput.isEmpty {
                    lap.quantity = Int(textInput) ?? 0
                }
            }
        }
    }
}

#Preview {
    EditLapView(lap: .constant(Lap.getLaps().first!))
}
