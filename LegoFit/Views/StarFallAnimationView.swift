//
//  StarFallAnimationView.swift
//  LegoFit
//
//  Created by Denis Denisov on 18/8/24.
//

import SwiftUI

struct StarFallAnimationView: View {
    let screenSize: CGSize
    @State private var emojis: [Star] = []
    
    var body: some View {
        ZStack {
            ForEach(emojis) { emoji in
                Text(emoji.symbol)
                    .font(.system(size: emoji.size))
                    .position(x: emoji.x, y: emoji.y)
                    .opacity(emoji.y > screenSize.height / 2
                             ? 1 - Double((emoji.y - screenSize.height / 2) / (screenSize.height / 2))
                             : 1)
            }
        }
        .onAppear {
            startFallingEmojis(screenWidth: screenSize.width)
        }
    }
    
    func startFallingEmojis(screenWidth: Double) {
        let timerRef = Timer.scheduledTimer(
            withTimeInterval: 0.2,
            repeats: true
        ) { timer in
            let newEmoji = Star(
                x: CGFloat.random(in: 0...screenWidth)
            )
            emojis.append(newEmoji)
            animateEmojiFalling(emoji: newEmoji)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            timerRef.invalidate()
        }
    }
        
    func animateEmojiFalling(emoji: Star) {
        if let index = emojis.firstIndex(where: { $0.id == emoji.id }) {
            withAnimation(.linear(duration: emoji.duration)) {
                emojis[index].y = screenSize.height + emoji.size
            }
        }
    }
}

#Preview {
    GeometryReader { geometry in
        return StarFallAnimationView(screenSize: geometry.size)
    }
}
