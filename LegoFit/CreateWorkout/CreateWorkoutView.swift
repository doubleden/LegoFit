//
//  CreateWorkoutView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutView: View {
    @State private var createWorkoutVM = CreateWorkoutViewModel()
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            MainGradientBackground()
                .ignoresSafeArea()
                .onTapGesture {
                    isFocused = false
                }
            ExerciseListAddView(
                exerciseListVM: ExerciseListAddViewModel(
                    workout: createWorkoutVM.workout
                ),
                isFocused: $isFocused
            )
            .padding(.top, 20)
            
            // Экран сохранения
            .sheet(isPresented: $createWorkoutVM.isSaveSheetPresented,
                   onDismiss: {
                if createWorkoutVM.isDidSave {
                    dismiss()
                }
            }) {
                CreateWorkoutSaveView( createWorkoutVM: createWorkoutVM ) .presentationDragIndicator(.visible)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        createWorkoutVM.cancelCreateWorkout()
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    ButtonWorkoutView(createWorkoutVM: $createWorkoutVM)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Exercises")
        .navigationBarTitleDisplayMode(.inline)
        .tint(.white)
    }
}

fileprivate struct ButtonWorkoutView: View {
    @Binding var createWorkoutVM: CreateWorkoutViewModel
    
    var body: some View {
        ZStack {
            Button("Workout") {
                createWorkoutVM.isSaveSheetPresented.toggle()
            }
            .disabled(createWorkoutVM.isExercisesInWorkoutEmpty)
            .buttonStyle(CustomButtonStyle(isDisabled: createWorkoutVM.isExercisesInWorkoutEmpty))
            if createWorkoutVM.workout.exercises.count > 0 {
                Text(createWorkoutVM.workout.exercises.count.formatted())
                    .font(.caption2)
                    .foregroundColor(.white)
                    .frame(width: 20)
                    .background(.venom)
                    .clipShape(Circle())
                    .offset(x: 30, y: -15)
            }
        }
    }
}

fileprivate struct CustomButtonStyle: ButtonStyle {
    let isDisabled: Bool
    
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8))
            .foregroundStyle(isDisabled ? .gray : .white)
            .background(isDisabled ? .offButton : .main)
            .clipShape(.rect(cornerRadius: 20))
            .scaleEffect(configuration.isPressed ? 0.7 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    let container = DataController.previewContainer
    
    return NavigationStack {
        CreateWorkoutView()
            .modelContainer(container)
    }
}

