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
                    
                    print(myWorkoutVM.workout.exercises.indices)
                }
                
                ExerciseList(myWorkoutVM: myWorkoutVM)
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

fileprivate struct ExerciseList: View {
    @Bindable var myWorkoutVM: MyWorkoutViewModel
    
    var body: some View {
        VStack(spacing:(-15)) {
            Divider()
            List {
                ForEach(myWorkoutVM.exercises) { exerciseType in
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
                        DisclosureGroup("Lap \(lap.quantity)") {
                            ForEach(lap.exercises) { exercise in
                                MyExerciseCellView(exercise: exercise) {
                                    myWorkoutVM.showDetailsView(
                                        exercise: exercise,
                                        type: exerciseType
                                    )
                                }
                                .lapExerciseRowStyle()
                            }
                            .onMove(perform: { indices, newOffset in
                                myWorkoutVM.moveExercise(in: lap, from: indices, to: newOffset)
                            })
                            .onDelete { indexSet in
                                myWorkoutVM.delete(in: lap, exerciseWith: indexSet)
                            }
                        }
                        .mainRowStyle()
                        .tint(.white)
                        .onChange(of: lap.exercises) { _, _ in
                            withAnimation(.smooth) {
                                myWorkoutVM.delete(lap: lap)
                            }
                        }
                    }
                }
                .onMove(perform: myWorkoutVM.move)
                .onDelete(perform: { indexSet in
                    myWorkoutVM.deleteExerciseType(indexSet)
                })
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
