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
    
    var body: some View {
        NavigationStack {
            List(workouts, id: \.self) { workout in
                Button(workout.name) {}
                    .swipeActions(allowsFullSwipe: true) {
                        
                    }
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
}

#Preview {
    MyWorkoutsView()
}
