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
        ZStack {
            MainGradientBackground()
                .ignoresSafeArea()
            VStack(spacing: 30) {
                CircleButton(
                    icon: Image(systemName: "play.fill"),
                    width: 100,
                    height: 100
                ) {
                    myWorkoutVM.startWorkout()
                }
                
                List(myWorkoutVM.exercises) { exerciseType in
                    switch exerciseType {
                    case .single(let exercise):
                        MyExerciseCellView(exercise: exercise) {
                            myWorkoutVM.showDetailsView(
                                exercise: exercise,
                                type: exerciseType
                            )
                        }
                        .mainRowStyle()
                        
                    case .lap(let lap):
                        Section {
                            ForEach(lap.exercises) { exercise in
                                MyExerciseCellView(exercise: exercise) {
                                    myWorkoutVM.showDetailsView(
                                        exercise: exercise,
                                        type: exerciseType
                                    )
                                }
                            }
                        } header: {
                            Text("Круг: \(lap.quantity)")
                                .font(.title2)
                        }
                        .mainRowStyle()
                    }
                }
                .mainListStyle()
                .padding()
                .sheet(item: $myWorkoutVM.sheetExercise) { exercise in MyWorkoutDetailsView(
                    myWorkoutDetailsVM: MyWorkoutDetailsViewModel(
                        exercise: exercise,
                        exerciseType: myWorkoutVM.sheetExerciseType
                                      ?? .single(exercise),
                        workout: myWorkoutVM.workout
                    )
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
}



import SwiftData
#Preview {
    let container = DataController.previewContainer
    let workouts = try? container.mainContext.fetch(FetchDescriptor<Workout>())
    let workout = workouts?.first ?? Workout.getWorkout()

    return NavigationStack {
        MyWorkoutView(myWorkoutVM: MyWorkoutViewModel(workout: workout))
            .modelContainer(container)
    }
}
