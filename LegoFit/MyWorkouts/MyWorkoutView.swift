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
    @State var isPresented = false
    var body: some View {
        VStack(spacing:(-15)) {
            Divider()
            List {
                ForEach(myWorkoutVM.exercises) { exerciseType in
                    switch exerciseType {
                    case .single(let exercise):
                        MyExerciseCellView(exercise: exercise)
                            .mainRowStyle()
                            .swipeActions(edge: .leading) {
                                ListEditButton {
                                    myWorkoutVM.showDetailsView(
                                        exercise: exercise,
                                        type: exerciseType
                                    )
                                }
                            }
                    case .lap(let lap):
                        DisclosureGroup("Lap: \(lap.quantity)") {
                            ForEach(lap.exercises) { exercise in
                                MyExerciseCellView(exercise: exercise, isInLap: true)
                                .lapExerciseRowStyle()
                                .swipeActions(edge: .leading) {
                                    ListEditButton {
                                        myWorkoutVM.showDetailsView(
                                            exercise: exercise,
                                            type: exerciseType
                                        )
                                    }
                                }
                            }
                            .onMove(perform: { indices, newOffset in
                                myWorkoutVM.moveExercise(in: lap, from: indices, to: newOffset)
                            })
                            .onDelete { indexSet in
                                withAnimation(.smooth) {
                                    myWorkoutVM.delete(inLap: lap, exerciseWith: indexSet)
                                }
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button("Edit lap", action: {
                                myWorkoutVM.showEditLapView(lap: lap)
                            })
                            .tint(Color.violet)
                        }
                        .mainRowStyle()
                        .tint(.white)
                    }
                }
                .onMove(perform: myWorkoutVM.moveCell)
                .onDelete(perform: myWorkoutVM.deleteCell)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {isPresented.toggle()}, label: {
                        Image(systemName: "plus.square.on.square")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .mainListStyle()
            .padding()
            .sheet(item: $myWorkoutVM.sheetExercise) { exercise in MyWorkoutEditExerciseView(
                    myWorkoutDetailsVM: MyWorkoutEditExerciseViewModel(
                        exercise: exercise,
                        exerciseType: myWorkoutVM.sheetExerciseType
                        ?? .single(exercise),
                        workout: myWorkoutVM.workout
                    )
                )
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
            }
            
            .sheet(item: $myWorkoutVM.sheetEditLap) { lap in
                MyWorkoutEditLapView(workout: myWorkoutVM.workout, lap: lap)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
            
            .sheet(isPresented: $isPresented,
                   content: {
                WorkoutEditView(
                    workoutEditVM: WorkoutEditViewModel(workout: myWorkoutVM.workout)
                )
                .presentationDragIndicator(.visible)
            })
        }
    }
}

struct ListEditButton: View {
    let action: () -> Void
    
    var body: some View {
        Button("Edit", action: action)
        .tint(.main)
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
