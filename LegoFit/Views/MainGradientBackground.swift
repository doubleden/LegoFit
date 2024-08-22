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
            colors: [.black, .darkGrey, .gray, .offButton],
            center: .top,
            angle: .degrees(30)
        )
        .ignoresSafeArea()
    }
}

#Preview {
    MainGradientBackground()
}
