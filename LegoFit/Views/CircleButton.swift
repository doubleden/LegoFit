//
//  StartWorkoutButton.swift
//  LegoFit
//
//  Created by Denis Denisov on 28/6/24.
//

import SwiftUI

struct CircleButton: View {
    let icon: Image
    let width: CGFloat
    let height: CGFloat
    var isDisable = false

    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .frame(width: width, height: height)
                    .foregroundStyle(
                        isDisable
                        ? AngularGradient(
                            colors: [.gray],
                            center: .center
                        )
                        : AngularGradient(
                            colors: [.blue, .sky],
                            center: .center,
                            angle: .degrees(300)
                        )
                    )
                    .shadow(color: .violet, radius: isDisable ? 0 : 4)
                icon
                    .foregroundStyle(.black)
                    .font(.largeTitle)
            }
        }
        .disabled(isDisable)
    }
}

#Preview {
    CircleButton(icon: Image(systemName: "play.fill"), width: 100, height: 100, action: {})
}
