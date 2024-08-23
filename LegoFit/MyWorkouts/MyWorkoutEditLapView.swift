//
//  EditLapView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/7/24.
//

import SwiftUI

struct MyWorkoutEditLapView: View {
    var workout: Workout
    var lap: Lap
    @Binding var selectedDetent: PresentationDetent
    @Binding var detents: Set<PresentationDetent>
    
    @State private var isListShow = false
    @State private var textInput = ""
    @State private var quantity = 0
    @FocusState private var isFocused
    @State private var arrowDegrees = -90.0
    @State private var isBlinking = false
    private let height: PresentationDetent = .height(260)
    
    var body: some View {
        NavigationStack {
            ZStack {
                MainGradientBackground()
                    .ignoresSafeArea()
                    .blur(radius: 10)
                
                VStack(spacing: 40) {
                    LapQuantityTF(
                        input: $textInput, isFocused: $isFocused) {
                            if quantity < 100 {
                                quantity += 1
                            }
                        } minusAction: {
                            if quantity > 0 {
                                quantity -= 1
                            }
                        }
                        .focused($isFocused)
                    
                    VStack {
                        VStack(spacing: 10) {
                            Image(systemName: "chevron.right.2")
                                .rotationEffect(.degrees(arrowDegrees))
                                .font(.title)
                                .opacity(isBlinking ? 0.4 : 1.0)
                                .offset(y: isBlinking ? 3 : 0)
                                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isBlinking)
                                .shadow(color: .yellow, radius: 2)
                            Text("Add Exercise")
                        }
                        .foregroundStyle(.orange)
                        
                        if isListShow {
                            EditMyWorkoutLapView(workout: workout, lap: lap)
                                .transition(
                                    .asymmetric(
                                        insertion: .move(edge: .bottom),
                                        removal: .move(edge: .bottom)
                                    )
                                )
                        } else {
                            Spacer()
                        }
                    }
                    .onChange(of: selectedDetent) { _, newValue in
                        withAnimation {
                            isListShow = newValue == .large
                            arrowDegrees = newValue == .large ? 90.0 : -90.0
                            updateDetentsWithDelay()
                        }
                    }
                }
                .padding(.top, 50)
                .onAppear {
                    quantity = lap.approach
                    textInput = quantity.formatted()
                    isBlinking.toggle()
                }
                .onChange(of: quantity) { _ , newValue in
                    textInput = newValue.formatted()
                }
                .onChange(of: textInput) { _, newValue in
                    quantity = Int(textInput) ?? 0
                }
                .onChange(of: isFocused) { _, _ in
                    if quantity > 100 {
                        quantity = 100
                    }
                }
                .onDisappear {
                    selectedDetent = height
                }
            }
            .onTapGesture {
                withAnimation {
                    isFocused = false
                }
            }
            .navigationTitle("Laps")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    SaveButton {
                        changeQuantity()
                    }
                }
            }
        }
    }
    
    private func changeQuantity() {
        guard let lapIndex = workout.findIndex(ofLap: lap) else { return }
        if case .lap(var workoutLap) = workout.exercises[lapIndex] {
            workoutLap.approach = quantity
            workout.exercises[lapIndex] = .lap(workoutLap)
        }
    }
    
    private func updateDetentsWithDelay() {
        Task {
            try? await Task.sleep(nanoseconds: 100_000_000)
            guard selectedDetent == .large else {
                detents = [height, .large]
                return
            }
            detents = [.large, height]
        }
    }
}


#Preview {
    let container = DataController.previewContainer
    let workout = Workout.getWorkout()
    
    return MyWorkoutEditLapView(workout: workout, lap: Lap.getLaps().first!, selectedDetent: .constant(.medium), detents: .constant([.large, .medium]))
        .modelContainer(container)
}
