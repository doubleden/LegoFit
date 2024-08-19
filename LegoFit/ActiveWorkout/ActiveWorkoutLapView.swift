//
//  ActiveWorkoutLapView.swift
//  LegoFit
//
//  Created by Denis Denisov on 15/8/24.
//

import SwiftUI

struct ActiveWorkoutLapView: View {
    let lap: Lap
    let completedApproach: Int
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                ApproachView(
                    text: "laps done",
                    completedApproach: completedApproach,
                    approach: lap.approach,
                    font: 30
                )
                .padding(.trailing)
                .padding(.bottom)
            }

            List(lap.exercises) { exercise in
                HStack(alignment: .bottom, spacing: 20) {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.gray.opacity(0.1))
                        
                        ExerciseParametersView(
                            exercise: exercise,
                            spacing: 10,
                            isPaddingForComment: false
                        )
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    VStack(alignment: .trailing) {
                        Text(exercise.name)
                            .font(.subheadline)
                        ExerciseImageView(imageUrl: exercise.image)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .listRowBackground(Color.clear)
            }
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
            .listStyle(PlainListStyle())
            .clipShape(RoundedRectangle(cornerRadius: 35))
            .overlay(RoundedRectangle(cornerRadius: 35).stroke().foregroundStyle(clearGray))
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ZStack {
        MainGradientBackground()
        VStack {
            ActiveWorkoutLapView(lap: Lap.getLaps().first!, completedApproach: 2)
            Spacer()
            Circle()
                .frame(width: 60, height: 50)
        }
    }
}
