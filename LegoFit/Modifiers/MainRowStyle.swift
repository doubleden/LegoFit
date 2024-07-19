//
//  MainRowStyle.swift
//  LegoFit
//
//  Created by Denis Denisov on 19/7/24.
//

import SwiftUI

struct MainRowStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .listRowBackground(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.gray)
                    .opacity(0.1)
            )
    }
}
