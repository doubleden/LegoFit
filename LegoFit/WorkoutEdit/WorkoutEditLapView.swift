//
//  WorkoutEditLapView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import SwiftUI

struct WorkoutEditLapView: View {
    @State var workoutEditLapVM: WorkoutEditLapViewModel
    
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
    return WorkoutEditLapView(workoutEditLapVM: WorkoutEditLapViewModel(workout: Workout.getWorkout(), lap: Lap.getLaps().first!))
        .modelContainer(container)
}
