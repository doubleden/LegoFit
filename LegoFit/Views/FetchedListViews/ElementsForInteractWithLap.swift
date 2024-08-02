//
//  ElementsForInteractWithLap.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import SwiftUI

protocol ElementsForInteractWithLapViewable {
    var lapQuantity: String { get set }
    var isAddingLap: Bool { get set }
    var sheetExercise: Exercise? { get }
    func isLapValid() -> Bool
    func addToWorkoutLap()
}

struct ElementsForInteractWithLap<ViewModel: ElementsForInteractWithLapViewable>: View {
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
                isDisable: !viewModel.isLapValid()
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
    }
}

#Preview {
    @FocusState var focus
    let container = DataController.previewContainer
    return ElementsForInteractWithLap(viewModel: .constant(CreateWorkoutViewModel()), isFocused: $focus)
        .modelContainer(container)
}
