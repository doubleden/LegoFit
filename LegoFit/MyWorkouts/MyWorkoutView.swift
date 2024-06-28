//
//  MyWorkoutsDitaisView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/6/24.
//

import SwiftUI

struct MyWorkoutView: View {
    @Bindable var myWorkoutVM: MyWorkoutViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text(myWorkoutVM.workout.name)
                    .font(.largeTitle)
                
                StartWorkoutButton {
                    myWorkoutVM.startWorkout()
                }
                
                List(myWorkoutVM.sortedExercise) { exercise in
                    Button(action: {
                        myWorkoutVM.sheetPresented = exercise
                    }) {
                        HStack(alignment: .center, spacing: 40) {
                            Text(exercise.name)
                            Spacer()
                            VStack(alignment: .
                                   trailing, spacing: 5) {
                                Text(exercise.set.formatted())
                                Text(exercise.rep.formatted())
                                Text(exercise.weight.formatted())
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: 20,
                    bottom: 0,
                    trailing: 20
                )
            )
            .navigationDestination(
                isPresented: $myWorkoutVM.isWorkoutStart,
                destination: {
                    ActiveWorkoutView(
                        activeWorkoutVM: ActiveWorkoutViewModel(
                            workout: myWorkoutVM.workout
                        )
                    )
                }
            )
            
            .alert(myWorkoutVM.alertMessage ?? "",
                   isPresented: $myWorkoutVM.isAlertPresented,
                   actions: {}
            )
            
            .sheet(item: $myWorkoutVM.sheetPresented) { exercise in MyWorkoutDetailsView(
                myWorkoutDetailsVM: MyWorkoutDetailsViewModel(exercise: exercise)
            )
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

    return MyWorkoutView(myWorkoutVM: MyWorkoutViewModel(workout: workout))
        .modelContainer(container)
}
