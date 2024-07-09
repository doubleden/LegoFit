//
//  MyWorkoutsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 31/5/24.
//

import SwiftUI
import SwiftData

struct MyWorkoutsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var workouts: [Workout]

    var body: some View {
        NavigationStack {
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
            .navigationTitle("My Workouts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        CreateWorkoutView()
                    } label: {
                        Image(systemName: "plus")
                            .tint(.main)
                    }

                }
            }
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
    MyWorkoutsView()
        .modelContainer(DataController.previewContainer)
}
