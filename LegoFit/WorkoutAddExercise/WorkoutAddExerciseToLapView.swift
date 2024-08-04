//
//  WorkoutEditLapView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import SwiftUI

struct WorkoutAddExerciseToLapView: View {
    @State var workoutEditLapVM: WorkoutAddExerciseToLapViewModel
    
    var body: some View {
        ZStack {
            MainGradientBackground()
                .ignoresSafeArea()
            FetchedExerciseListView(viewModel: $workoutEditLapVM)
                .padding(.top,40)
        }
    }
}

#Preview {
    let container = DataController.previewContainer
    return WorkoutAddExerciseToLapView(workoutEditLapVM: WorkoutAddExerciseToLapViewModel(workout: Workout.getWorkout(), lap: Lap.getLaps().first!))
        .modelContainer(container)
}
