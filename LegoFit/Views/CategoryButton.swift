//
//  CategoryButton.swift
//  LegoFit
//
//  Created by Denis Denisov on 8/8/24.
//

import SwiftUI

struct CategoryButton: View {
    let title: String
    let action: () -> Void
    
    @State private var isDisabled = true
    
    var body: some View {
        Button(action: {
            isDisabled.toggle()
            action()
        }) {
            Text(title)
                .foregroundStyle(isDisabled ? .gray : .white)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .buttonStyle(CustomButtonStyle(isDisabled: $isDisabled))
    }
}

fileprivate struct CustomButtonStyle: ButtonStyle {
    @Binding var isDisabled: Bool
    
    private let onColor = Gradient(colors: [.main, .violet])
    private let offColor = Gradient(colors: [.offButton])
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(isDisabled ? offColor : onColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: isDisabled ? .clear : .venom, radius: 2)
    }
}

#Preview {
    CategoryButton(title: "shoulders", action: {})
}
