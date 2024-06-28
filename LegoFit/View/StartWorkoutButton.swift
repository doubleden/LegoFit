//
//  StartWorkoutButton.swift
//  LegoFit
//
//  Created by Denis Denisov on 28/6/24.
//

import SwiftUI

struct StartWorkoutButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Gradient(colors: [.main, .violet]))
                    .shadow(color: .violet, radius: 7)
                
                Image(systemName: "play.fill")
                    .foregroundStyle(.black)
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    StartWorkoutButton(action: {})
}
