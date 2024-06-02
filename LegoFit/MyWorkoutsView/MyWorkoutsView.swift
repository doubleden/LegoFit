//
//  MyWorkoutsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 31/5/24.
//

import SwiftUI
import SwiftData

struct MyWorkoutsView: View {
    @Query var workouts: [Workout]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(workouts) { workout in
                    NavigationLink(workout.name, destination: MyWorkoutsDetailsView(workout: workout))
                }
                .onDelete(perform: { indexSet in
                    deleteWorkout(indexSet)
                })
            }
            .navigationTitle("My Workouts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: CreateWorkoutView()) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
    
    func deleteWorkout(_ indexSet: IndexSet) {
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
