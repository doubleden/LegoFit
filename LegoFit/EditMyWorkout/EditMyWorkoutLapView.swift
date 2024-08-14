//
//  WorkoutEditLapView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/8/24.
//

import SwiftUI

struct EditMyWorkoutLapView: View {
    let workout: Workout
    let lap: Lap
    @State private var workoutEditLapVM: EditMyWorkoutLapViewModel
    
    var body: some View {
        ZStack {
            MainGradientBackground()
                .ignoresSafeArea()
            FetchedExerciseListView(viewModel: $workoutEditLapVM)
                .padding(.top,40)
        }
    }
    
    init(workout: Workout, lap: Lap) {
        self.workout = workout
        self.lap = lap
        self.workoutEditLapVM = EditMyWorkoutLapViewModel(workout: workout, lap: lap)
    }
}

#Preview {
    let container = DataController.previewContainer
    return EditMyWorkoutLapView(workout: Workout.getWorkout(), lap: Lap.getLaps().first!)
        .modelContainer(container)
}
