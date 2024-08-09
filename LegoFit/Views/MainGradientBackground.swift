//
//  MainGradientBackground.swift
//  LegoFit
//
//  Created by Denis Denisov on 19/7/24.
//

import SwiftUI

struct MainGradientBackground: View {
    var body: some View {
        AngularGradient(
            colors: [.night, .rose, .sky, .purple, .cosmos],
            center: .top,
            angle: .degrees(70)
        )
        .ignoresSafeArea()
    }
}

#Preview {
    MainGradientBackground()
}
