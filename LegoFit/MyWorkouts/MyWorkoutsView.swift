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
    @Query(filter: #Predicate<Workout> { workout in
        !workout.isDone
    }) var workouts: [Workout]
    
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
                .mainRowStyle()
            }
            .mainListStyle()
            .background(
                MainGradientBackground()
            )
            .navigationTitle("My Workouts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: CreateWorkoutView()) {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                    }
                }
            }
        }
        .tint(.white)
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
