//
//  WorkoutEditLapView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import SwiftUI

struct EditMyWorkoutLapView: View {
    @State var workoutEditLapVM: EditMyWorkoutLapViewModel
    
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
    return EditMyWorkoutLapView(workoutEditLapVM: EditMyWorkoutLapViewModel(workout: Workout.getWorkout(), lap: Lap.getLaps().first!))
        .modelContainer(container)
}
