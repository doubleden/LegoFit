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
                .listRowSeparator(.hidden)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.gray)
                        .opacity(0.1)
                )
            }
            .listRowSpacing(5)
            .navigationTitle("My Workouts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        CreateWorkoutView()
                    } label: {
                        Image(systemName: "plus.circle")
                            .tint(.main)
                            .font(.title2)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(
                Gradient(
                    colors: [.cosmos, .cosmos, .gray]
                )
            )
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
