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
    @State private var isFlashOn = false
    
    var body: some View {
        ZStack {
            MainGradientBackground()
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(
                            .yellow.opacity(0.8),
                            lineWidth: isFlashOn ? 30 : 0
                        )
                        .shadow(
                            color: .yellow.opacity(0.8),
                            radius: isFlashOn ? 10 : 0
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20)
                        )
                )
                .ignoresSafeArea()
                .blur(radius: 3)
            
            GeometryReader { geometry in
                StarFallAnimationView(screenSize: geometry.size)
                
                VStack(spacing: 40) {
                    LabelGradientBackground(
                        content:
                            Text("You did it!")
                            .font(.largeTitle)
                            .foregroundStyle(
                                AngularGradient(
                                    colors: [.yellow, .orange],
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
                    withAnimation {
                        isFlashOn.toggle()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation {
                            isFlashOn.toggle()
                        }
                    }
                }
            }
        }
    }
}

fileprivate struct ButtonCustomStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 15, leading: 35, bottom: 15, trailing: 35))
            .font(.title2)
            .foregroundStyle(.black)
            .background(configuration.isPressed ? .clear : .orange)
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
