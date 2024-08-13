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
    @State private var isPresented = false
    
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
            }
            .onTapGesture {
                isFocused = false
            }
            .navigationTitle("Quantity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { isPresented.toggle() }, label: {
                        Text("Add Exercise")
                            .foregroundStyle(.white)
                            .padding(.leading, 6)
                    })
                    .background(Gradient(colors: [.gray.opacity(mainOpacity), .blue]))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    SaveButton {
                        changeQuantity()
                    }
                }
            }
            .sheet(isPresented: $isPresented,
                   content: {
                EditMyWorkoutLapView(
                    workoutEditLapVM: EditMyWorkoutLapViewModel(
                        workout: workout,
                        lap: lap
                    )
                )
                .presentationDragIndicator(.visible)
            })
        }
    }
    
    private func changeQuantity() {
        guard let lapIndex = workout.findIndex(ofLap: lap) else { return }
        if case .lap(var workoutLap) = workout.exercises[lapIndex] {
            workoutLap.quantity = quantity
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
