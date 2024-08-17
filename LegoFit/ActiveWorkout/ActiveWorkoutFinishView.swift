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
    
    var body: some View {
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
