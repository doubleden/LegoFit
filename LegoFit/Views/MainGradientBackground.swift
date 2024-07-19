//
//  MainGradientBackground.swift
//  LegoFit
//
//  Created by Denis Denisov on 19/7/24.
//

import SwiftUI

struct MainGradientBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [.cosmos, .black]
            ),
            startPoint: .center,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

#Preview {
    MainGradientBackground()
}
