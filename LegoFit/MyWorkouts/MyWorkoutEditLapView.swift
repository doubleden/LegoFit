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
        ZStack {
            MainGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 35) {
                Text("Quantity")
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
                Spacer()
                SaveButton {
                    changeQuantity()
                }
                Spacer()
            }
            .padding()
            .padding(.top, 20)
            .onAppear {
                quantity = lap.quantity
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
        .onTapGesture {
            isFocused = false
        }
    }
    
    private func changeQuantity() {
        if let index = workout.exercises.firstIndex(where: {
            if case .lap(let workoutLap) = $0 {
                return workoutLap.id == lap.id
            }
            return false
        }) {
            if case .lap(var workoutLap) = workout.exercises[index] {
                workoutLap.quantity = quantity
                workout.exercises[index] = .lap(workoutLap)
            }
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
