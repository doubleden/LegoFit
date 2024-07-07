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
            
            List(myWorkoutVM.exercises) { exerciseType in
                switch exerciseType {
                case .single(let exercise):
                    MyExerciseCellView(exercise: exercise) {
                        myWorkoutVM.showDetailsView(exercise: exercise, type: exerciseType, queue: exercise.queue ?? 0)
                    }
                    
                case .lap(let lap):
                    Section {
                        ForEach(lap.exercises) { exercise in
                            MyExerciseCellView(exercise: exercise) {
                                myWorkoutVM.showDetailsView(exercise: exercise, type: exerciseType, queue: lap.queue, queueForLap:lap.exercises.firstIndex(where: exercise))
                            }
                        }
                    } header: {
                        Text("Круг: \(lap.quantity)")
                            .font(.title2)
                    }
                }
            }
            .padding()
            .sheet(item: $myWorkoutVM.sheetExerciseDetails) { exercise in MyWorkoutDetailsView(
                myWorkoutDetailsVM: MyWorkoutDetailsViewModel(workout: myWorkoutVM.workout, queue: myWorkoutVM.sheetExerciseQueue, queueInLap: myWorkoutVM.sheetExerciseInLapQueue, exerciseType: myWorkoutVM.sheetExerciseType, exercise: myWorkoutVM.sheetExerciseDetails)
            )
            .presentationDetents([.height(320)])
            .presentationDragIndicator(.visible)
            }
        }
        .navigationTitle(myWorkoutVM.workout.name)
//        .navigationDestination(
//            isPresented: $myWorkoutVM.isWorkoutStart,
//            destination: {
//                ActiveWorkoutView(
//                    activeWorkoutVM: ActiveWorkoutViewModel(
//                        workout: myWorkoutVM.workout
//                    )
//                )
//            }
//        )
        
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
