//
//  ExerciseListAddView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import SwiftUI

struct ExerciseListAddView: View {
    @Binding var exerciseListVM: ExerciseListAddViewModel
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        VStack {
            if exerciseListVM.isAddingLap {
                LapElements(
                    exerciseListVM: $exerciseListVM,
                    isFocused: $isFocused
                )
            }
            FetchedExerciseListView(viewModel: $exerciseListVM)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ButtonLap(isAddingLap: $exerciseListVM.isAddingLap)
            }
        }
    }
}

fileprivate struct LapElements: View {
    @Binding var exerciseListVM: ExerciseListAddViewModel
    @FocusState.Binding var isFocused: Bool
    var body: some View {
        VStack {
            TextField("Quantity of laps", text: $exerciseListVM.lapQuantity)
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
                isDisable: !exerciseListVM.isLapValid()
            ) {
                exerciseListVM.addToWorkoutLap()
                withAnimation(.smooth) {
                    exerciseListVM.isAddingLap.toggle()
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
        .onChange(of: exerciseListVM.sheetExercise, {
            if isFocused {
                isFocused = false
            }
        })
        .onChange(of: exerciseListVM.isAddingLap) { _, _ in
            exerciseListVM.clearLapInputs()
        }
    }
}

#Preview {
    @FocusState var focus
    let container = DataController.previewContainer
    @State var exerciseVM = ExerciseListAddViewModel(workout: Workout.getWorkout())
    return NavigationStack { ExerciseListAddView(exerciseListVM: .constant(exerciseVM), isFocused: $focus)
            .modelContainer(container)
    }
}
