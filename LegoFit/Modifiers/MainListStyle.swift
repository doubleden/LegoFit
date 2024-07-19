//
//  MainListStyle.swift
//  LegoFit
//
//  Created by Denis Denisov on 19/7/24.
//

import SwiftUI

struct MainListStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environment(\.defaultMinListRowHeight, 50)
            .listRowSpacing(5)
            .scrollContentBackground(.hidden)
            .background(
                MainGradientBackground()
            )
    }
}
