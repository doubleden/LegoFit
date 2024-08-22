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
                exerciseListVM: $createWorkoutVM.exerciseListAddVM,
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
                
                ToolbarItem(placement: .principal) {
                    ButtonWorkoutView(createWorkoutVM: $createWorkoutVM)
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .tint(.white)
    }
}

fileprivate struct ButtonWorkoutView: View {
    @Binding var createWorkoutVM: CreateWorkoutViewModel
    
    var body: some View {
        Button("Workout") {
            createWorkoutVM.isSaveSheetPresented.toggle()
        }
        .disabled(createWorkoutVM.isExercisesInWorkoutEmpty)
        .buttonStyle(CustomButtonStyle(isDisabled: createWorkoutVM.isExercisesInWorkoutEmpty))
        .overlay(
            createWorkoutVM.workout.exercises.count > 0
            ? AnyView(BadgeView(
                number: createWorkoutVM.workout.exercises.count)
                .offset(x: 7, y: -6)
            )
            : AnyView(Circle().opacity(0))
            ,alignment: .topTrailing
        )
    }
}

fileprivate struct CustomButtonStyle: ButtonStyle {
    let isDisabled: Bool
    
    let off = AngularGradient(colors: [.black, .cosmos, .offButton, .black, .offButton], center: .top, angle: .degrees(40))
    let on = AngularGradient(
        gradient: Gradient(colors: [.violet, .rose, .night, .sky, .cosmos]),
        center: .top,
        angle: .degrees(40)
    )
    
    @ViewBuilder
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 8, leading: 13, bottom: 8, trailing: 13))
            .foregroundStyle(isDisabled ? .gray : .white)
            .background(isDisabled ? off : on)
            .clipShape(.rect(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.7 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct BadgeView: View {
    let number: Int
    
    var body: some View {
        Text(number.formatted())
            .font(.caption2)
            .foregroundColor(.black)
            .frame(width: 20)
            .background(.yellow)
            .clipShape(Circle())
    }
}

#Preview {
    let container = DataController.previewContainer
    
    return NavigationStack {
        CreateWorkoutView()
            .modelContainer(container)
    }
}
