//
//  CategoryButton.swift
//  LegoFit
//
//  Created by Denis Denisov on 8/8/24.
//

import SwiftUI

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .foregroundStyle(!isSelected ? .gray : .white)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .buttonStyle(CustomButtonStyle(isSelected: isSelected))
    }
}

fileprivate struct CustomButtonStyle: ButtonStyle {
    var isSelected: Bool
    
    private let onColor = Gradient(colors: [.main, .violet])
    private let offColor = Gradient(colors: [clearGray])
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(!isSelected ? offColor : onColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
    }
}

#Preview {
    CategoryButton(title: "shoulders", isSelected: true, action: {})
}
