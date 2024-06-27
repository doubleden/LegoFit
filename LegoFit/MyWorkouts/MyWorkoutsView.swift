//
//  MyWorkoutsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 31/5/24.
//

import SwiftUI
import SwiftData

struct MyWorkoutsView: View {
    @Binding var selectedTab: Int
    @Query var workouts: [Workout]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(workouts) { workout in
                        NavigationLink(
                            workout.name,
                            destination: MyWorkoutView(
                                myWorkoutVM: MyWorkoutViewModel(workout: workout)
                            )
                        )
                    }
                    .onDelete(perform: { indexSet in
                        deleteWorkout(indexSet)
                    })
                }
            }
            .navigationTitle("Мои тренировки")
        }
    }
    
    private func deleteWorkout(_ indexSet: IndexSet) {
        for index in indexSet {
            let workout = workouts[index]
            modelContext.delete(workout)
        }
    }
}

#Preview {
    MyWorkoutsView(selectedTab: .constant(0))
        .modelContainer(DataController.previewContainer)
}
