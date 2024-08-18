//
//  ActiveWorkoutFinishView.swift
//  LegoFit
//
//  Created by Denis Denisov on 15/8/24.
//

import SwiftUI

struct ActiveWorkoutFinishView: View {
    @Binding var input: String
    let action: () -> Void
    
    @FocusState private var isFocused
    @State private var isHidden = false
    
    @State private var animationRunning = true
    @State private var emojis = [Emoji]()
    @State private var screenHeight: CGFloat = 0

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ForEach(emojis) { emoji in
                    Text(emoji.symbol)
                        .font(.system(size: emoji.size))
                        .opacity(emoji.y > screenHeight / 2 ? 1 - Double((emoji.y - screenHeight / 2) / (screenHeight / 2)) : 1)                        .position(x: emoji.x, y: emoji.y)
                        .animation(.linear(duration: emoji.duration), value: emoji.y)
                }
                VStack(spacing: 40) {
                    LabelGradientBackground(
                        content:
                            Text("You did it!")
                            .font(.largeTitle)
                            .foregroundStyle(
                                AngularGradient(
                                    colors: [.yellow, .orange, .sky],
                                    center: .center
                                )
                            )
                    )
                    if !isHidden {
                        GeometryReader { geometry in
                            Image("champion")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(
                                    width: geometry.size.width,
                                    height: geometry.size.height / 1.1
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .clipped()
                                .shadow(radius: 20)
                        }
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .top).combined(with: .scale(scale: 0, anchor: .top)),
                                removal: .scale(scale: 0, anchor: .top).combined(with: .push(from: .bottom))
                            )
                        )
                        .animation(.easeInOut(duration: 0.5), value: isFocused)
                    }
                    
                    VStack {
                        HStack {
                            Text("Leave comment of your workout:")
                                .font(.callout)
                            Spacer()
                        }
                        TextField(
                            "I gained more weight in...",
                            text: $input,
                            axis: .vertical
                        )
                        .padding()
                        .frame(alignment: .topLeading)
                        .background(clearGray)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .focused($isFocused)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                HStack {
                                    Spacer()
                                    Button("Done") {
                                        isFocused = false
                                    }
                                }
                            }
                        }
                        .tint(.white)
                    }
                    Spacer()
                    Button("Exit") {
                        startVibrationSuccess()
                        action()
                    }
                    .buttonStyle(ButtonCustomStyle())
                }
                .padding()
                .toolbar(.hidden, for: .navigationBar)
                .onTapGesture {
                    isFocused = false
                }
                .onChange(of: isFocused) { _, _ in
                    withAnimation {
                        isHidden = isFocused
                    }
                }
                
                .onAppear {
                    startRattleVibration()
                }
                
                .onAppear {
                    screenHeight = geometry.size.height
                    startFallingEmojis()
                    stopAnimationAfter(seconds: 5)
                }
            }
        }
    }
    
    func startFallingEmojis() {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            if !animationRunning {
                timer.invalidate()
                return
            }
            let newEmoji = Emoji(
                id: UUID(),
                symbol: "⭐️",
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: 0,
                size: CGFloat.random(in: 30...50),
                duration: Double.random(in: 3...6)
            )
            emojis.append(newEmoji)
            animateEmojiFalling(emoji: newEmoji)
        }
    }
        
    func animateEmojiFalling(emoji: Emoji) {
        if let index = emojis.firstIndex(where: { $0.id == emoji.id }) {
            withAnimation {
                emojis[index].y = screenHeight + emoji.size
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + emoji.duration) {
                emojis.removeAll { $0.id == emoji.id }
            }
        }
    }
    
    func stopAnimationAfter(seconds: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            animationRunning = false
        }
    }
}

fileprivate struct ButtonCustomStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
            .font(.title2)
            .background(configuration.isPressed ? .clear : .rose)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    ZStack {
        MainGradientBackground()
        VStack {
            ActiveWorkoutFinishView(input: .constant(""), action: {})
        }
    }
}

struct Emoji: Identifiable {
    let id: UUID
    var symbol: String
    var x: CGFloat
    var y: CGFloat
    let size: CGFloat
    let duration: Double
}
