//
//  EditLapView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/7/24.
//

import SwiftUI

struct EditLapView: View {
    var workout: Workout
    var lap: Lap
    
    @State private var textInput = ""
    
    var body: some View {
        ZStack {
            MainGradientBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Text("Quantity")
                ParameterTextFieldView(
                    title: "Lap",
                    text: lap.quantity.formatted(),
                    input: $textInput
                )
                SaveButton {
                    changeQuantity()
                }
            }
        }
    }
    
    private func changeQuantity() {
        if let newQuantity = Int(textInput) {
            if let index = workout.exercises.firstIndex(where: {
                if case .lap(let workoutLap) = $0 {
                    return workoutLap.id == lap.id
                }
                return false
            }) {
                if case .lap(var workoutLap) = workout.exercises[index] {
                    workoutLap.quantity = newQuantity
                    workout.exercises[index] = .lap(workoutLap)
                }
            }
        }
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    let workout = Workout.getWorkout()
    
    return EditLapView(workout: workout, lap: Lap.getLaps().first!)
        .modelContainer(container)
}
