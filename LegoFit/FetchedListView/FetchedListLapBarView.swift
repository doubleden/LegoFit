//
//  FetchedListLapBarView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import SwiftUI

protocol FetchedListLapBarViewable: FetchedListViewable {
    func addToWorkoutLap()
    var lapQuantity: String { get set }
    var exercisesInLaps: [Exercise] { get set }
}

struct FetchedListLapBarView<ViewModel: FetchedListLapBarViewable>: View {
    @Binding var viewModel: ViewModel
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        VStack {
            TextField("Quantity of laps", text: $viewModel.lapQuantity)
                .focused($isFocused)
                .keyboardType(.numberPad)
                .padding()
                .frame(width: 170, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.main)
                )
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
            
            
            CircleButton(
                icon: Image(systemName: "plus"),
                width: 50,
                height: 50,
                isDisable: !isLapValid()
            ) {
                viewModel.addToWorkoutLap()
                withAnimation(.smooth) {
                    viewModel.isAddingLap.toggle()
                    isFocused = false
                }
            }
            .padding(
                EdgeInsets(
                    top: 5,
                    leading: 0,
                    bottom: 15,
                    trailing: 0
                )
            )
        }
        .onChange(of: viewModel.sheetExercise, {
            if isFocused {
                isFocused = false
            }
        })
        .onChange(of: viewModel.isAddingLap) { _, _ in
            clearLapInputs()
        }
    }
    private func clearLapInputs() {
        viewModel.lapQuantity = ""
        viewModel.exercisesInLaps = []
    }
    
    private func isLapValid() -> Bool {
        !viewModel.lapQuantity.isEmpty && !viewModel.exercisesInLaps.isEmpty
    }
}

#Preview {
    @FocusState var focus
    let container = DataController.previewContainer
    return FetchedListLapBarView(viewModel: .constant(CreateWorkoutViewModel()), isFocused: $focus)
        .modelContainer(container)
}
