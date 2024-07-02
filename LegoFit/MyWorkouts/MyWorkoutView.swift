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
        VStack(spacing: 30) {
            
            StartWorkoutButton {
                myWorkoutVM.startWorkout()
            }
            
            List(myWorkoutVM.sortedExercise) { exercise in
                Button(action: {
                    myWorkoutVM.showDetailsView(of: exercise)
                }) {
                    HStack(alignment: .center, spacing: 40) {
                        Text(exercise.name)
                        Spacer()
                        VStack(alignment: .trailing, spacing: 5) {
                            Text(exercise.set.formatted())
                            Text(exercise.rep.formatted())
                            Text(exercise.weight.formatted())
                        }
                    }
                }
            }
            .listStyle(.plain)
            //Временно
            List(myWorkoutVM.workout.laps) { lap in
                Section("\(lap.set)") {
                    ForEach(lap.exercises) { exercise in
                        Button(action: {
                            myWorkoutVM.showDetailsView(of: exercise)
                        }) {
                            HStack(alignment: .center, spacing: 40) {
                                Text(exercise.name)
                                Spacer()
                                VStack(alignment: .trailing, spacing: 5) {
                                    Text(exercise.set.formatted())
                                    Text(exercise.rep.formatted())
                                    Text(exercise.weight.formatted())
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .padding()
            .sheet(item: $myWorkoutVM.sheetExerciseDetails) { exercise in MyWorkoutDetailsView(
                myWorkoutDetailsVM: MyWorkoutDetailsViewModel(
                    exercise: exercise
                )
            )
            .presentationDetents([.height(320)])
            .presentationDragIndicator(.visible)
            }
        }
        .navigationTitle(myWorkoutVM.workout.name)
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
