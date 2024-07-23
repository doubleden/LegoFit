//
//  CreateWorkoutDetailsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutDetailsView: View {
    @Binding var createWorkoutVM: CreateWorkoutViewModel
    
    private var exercise: Exercise {
        createWorkoutVM.sheetExercise ?? Exercise.getExercises()[0]
    }
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: FocusedTextField?
    
    var body: some View {
        NavigationStack {
            ZStack {
                MainGradientBackground()
                    .ignoresSafeArea()
                VStack(spacing: 40) {
                    LabelGradientBackground(content:
                        Text(exercise.name)
                            .font(.title)
                    )
                    
                    ExerciseImageView(imageUrl: exercise.image)
                        .shadow(color: .main, radius: 10, x: 3, y: 3)
                    Text(exercise.description)
                        .padding()
                        .font(.callout)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.main))
                        
                    Spacer()
                    
                }
                .padding()
                .toolbar {
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            guard let exercise = createWorkoutVM.makeChangesInExercise() else {
                                return
                            }
                            createWorkoutVM.add(exercise: exercise)
                            dismiss()
                        }, label: {
                            Image(systemName: "plus.circle")
                                .font(.title3)
                        })
                        .tint(.main)
                    }
                    
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button(
                                createWorkoutVM.isFocused == .comment
                                ? "Done"
                                : "Next"
                            ) {
                                createWorkoutVM.changeIsFocused()
                                self.isFocused = createWorkoutVM.isFocused
                            }
                        }
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 65)
            }
            }
        }
        
        .onChange(of: isFocused, { _, newValue in
            createWorkoutVM.isFocused = newValue
        })
        
        .onTapGesture {
            isFocused = nil
        }
        
        .onDisappear {
            createWorkoutVM.clearExerciseInputs()
        }
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    return CreateWorkoutDetailsView(createWorkoutVM: .constant(CreateWorkoutViewModel()))
        .modelContainer(container)
}
