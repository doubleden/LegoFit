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
        VStack {
            Text("Quantity: \(lap.approach) of \(completedApproach)")
            List(lap.exercises) { exercise in
                HStack {
                    ExerciseImageView(imageUrl: exercise.image)
                        .frame(width: 120)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(exercise.name)
                        Text("\(exercise.rep ?? 0) reps")
                        Text("\(exercise.weight ?? "0") kg")
                    }
                }
                .mainRowStyle()
            }
            .mainListStyle()
        }
    }
}

#Preview {
    ZStack {
        MainGradientBackground()
        VStack {
            ActiveWorkoutLapView(lap: Lap.getLaps().first!, completedApproach: 2)
            Spacer()
            Button("Done", action: {})
        }
    }
}
