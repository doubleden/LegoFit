//
//  CreateWorkoutAddLapView.swift
//  LegoFit
//
//  Created by Denis Denisov on 21/7/24.
//

import SwiftUI

struct CreateWorkoutAddLapView: View {
    @Binding var createWorkoutVM: CreateWorkoutViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var IsFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                MainGradientBackground()
                    .ignoresSafeArea()
                VStack {
                    TextField("Quantity of laps", text: $createWorkoutVM.lapQuantity)
                        .focused($IsFocused)
                        .keyboardType(.numberPad)
                        .padding()
                        .frame(width: 170, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.main)
                        )
                    
                    FetchedExerciseListView(createWorkoutVM: $createWorkoutVM)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add lap") {
                            createWorkoutVM.addToWorkoutLap()
                            dismiss()
                        }
                        .disabled(!createWorkoutVM.isLapValid())
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
            .sheet(item: $createWorkoutVM.sheetExercise) { exercise in
                CreateWorkoutDetailsView(
                    exercise: exercise,
                    createWorkoutVM: $createWorkoutVM
                )
            }
                        
            .onTapGesture {
                IsFocused = false
            }
            
            .onAppear {
                IsFocused = true
            }
            
            .onDisappear {
                createWorkoutVM.clearLapInputs()
            }
        }
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    
    return NavigationStack {
            CreateWorkoutAddLapView(createWorkoutVM: .constant(CreateWorkoutViewModel()))
                .modelContainer(container)
        }
}
