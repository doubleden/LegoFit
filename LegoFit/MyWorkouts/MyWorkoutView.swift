//
//  MyWorkoutsDitaisView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/6/24.
//

import SwiftUI

struct MyWorkoutView: View {
    let workout: Workout
    @Bindable var myWorkoutVM: MyWorkoutViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text(workout.name)
                    .font(.largeTitle)
                
                Button(action: {}) {
                    ZStack {
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(Gradient(colors: [.main, .violet]))
                            .shadow(color: .violet, radius: 7)
                        
                        Image(systemName: "play.fill")
                            .foregroundStyle(.black)
                            .font(.largeTitle)
                    }
                }
                
                List(myWorkoutVM.sortedExercise) { exercise in
                    Button(action: {
                        myWorkoutVM.sheetPresented = exercise
                    }) {
                        HStack(alignment: .center, spacing: 40) {
                            Text(exercise.name)
                            Spacer()
                            VStack(alignment: .leading, spacing: 5) {
                                Text(exercise.set.formatted())
                                Text(exercise.rep.formatted())
                                Text(exercise.weight.formatted())
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .padding()
            .sheet(item: $myWorkoutVM.sheetPresented) { exercise in MyWorkoutDetailsView(exercise: exercise)
                    .presentationDetents([.height(320)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}


import SwiftData
#Preview {
    let container = DataController.previewContainer
    let workouts = try? container.mainContext.fetch(FetchDescriptor<Workout>())
    let workout = workouts?.first ?? Workout.getWorkout()

    return MyWorkoutView(workout: workout, myWorkoutVM: MyWorkoutViewModel(workout: workout))
        .modelContainer(container)
}
