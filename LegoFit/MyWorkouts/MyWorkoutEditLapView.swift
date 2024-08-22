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
    
    @State private var textInput = ""
    @State private var quantity = 0
    @FocusState private var isFocused
    
    var body: some View {
        NavigationStack {
            ZStack {
                MainGradientBackground()
                    .ignoresSafeArea()
                    .blur(radius: 10)
                ScrollView {
                    VStack(spacing: 30) {
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
                    }
                    .padding(.top, 30)
                    .onAppear {
                        quantity = lap.approach
                        textInput = quantity.formatted()
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
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink("Add Exercise") {
                        EditMyWorkoutLapView(workout: workout, lap: lap)
                    }
                    .foregroundStyle(.orange)
                }
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
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    let workout = Workout.getWorkout()
    
    return MyWorkoutEditLapView(workout: workout, lap: Lap.getLaps().first!)
        .modelContainer(container)
}
