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
    @State private var createWorkoutViewIsPresented = false
    
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
            .navigationTitle("My Workouts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        createWorkoutViewIsPresented.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .tint(.main)
                            .font(.title2)
                    })
                }
            }
            
            .sheet(isPresented: $createWorkoutViewIsPresented,
                   content: {
                CreateWorkoutView()
            })
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
