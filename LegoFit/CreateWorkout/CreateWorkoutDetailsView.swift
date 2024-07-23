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
                            createWorkoutVM.add(exercise: exercise)
                        }, label: {
                            Image(systemName: "plus.circle")
                                .font(.title3)
                        })
                        .tint(.main)
                    }
                }
            }
        }
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    return CreateWorkoutDetailsView(createWorkoutVM: .constant(CreateWorkoutViewModel()))
        .modelContainer(container)
}
