//
//  MyWorkoutsDitaisView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/6/24.
//

import SwiftUI

struct MyWorkoutView: View {
    @Bindable var myWorkoutVM: MyWorkoutViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.editMode) private var editMode

    var body: some View {
        ZStack {
            MainGradientBackground()
                .ignoresSafeArea()
            VStack(spacing: 30) {
                if editMode?.wrappedValue.isEditing == true {
                    TextFieldTitle(myWorkoutVM: myWorkoutVM)
                } else {
                    Text(myWorkoutVM.workout.name)
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    CircleButton(
                        icon: Image(systemName: "play.fill"),
                        width: 100,
                        height: 100
                    ) {
                        startVibrationSuccess()
                        myWorkoutVM.startWorkout()
                    }
                    .fullScreenCover(
                        item: $myWorkoutVM.activeWorkout,
                        onDismiss: {
                            if myWorkoutVM.workout.isDone {
                                dismiss()
                            }
                        }) { workout in
                            ActiveWorkoutView(workout: workout)
                        }
                }
                
                ExerciseList(myWorkoutVM: myWorkoutVM)
            }
            .toolbar {
                EditButton()
            }
            .alert(myWorkoutVM.alertMessage ?? "",
                   isPresented: $myWorkoutVM.isAlertPresented,
                   actions: {}
            )
            .environment(\.editMode, editMode)
        }
    }
}

fileprivate struct ExerciseList: View {
    @Bindable var myWorkoutVM: MyWorkoutViewModel
    @State var isPresented = false
    var body: some View {
        VStack(spacing:(0)) {
            DividerHorizontalView()
            List {
                ForEach(myWorkoutVM.exercises) { exerciseType in
                    switch exerciseType {
                    case .single(let exercise):
                        ExerciseCellView(exercise: exercise)
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
                        DisclosureGroup("Lap: \(lap.approach)") {
                            ForEach(lap.exercises) { exercise in
                                ExerciseCellView(exercise: exercise, isInLap: true)
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
                            .tint(.orange)
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
                        Image(systemName: "plus.circle")
                    })
                }
            }
            .scrollIndicators(.hidden)
            .mainListStyle()
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            .sheet(item: $myWorkoutVM.sheetExercise) { exercise in MyWorkoutEditExerciseView(
                    myWorkoutDetailsVM: MyWorkoutEditExerciseViewModel(
                        exercise: exercise,
                        exerciseType: myWorkoutVM.sheetExerciseType
                        ?? .single(exercise),
                        workout: myWorkoutVM.workout
                    )
                )
            .presentationDetents([.height(300)])
            .presentationDragIndicator(.visible)
            }
            
            .sheet(item: $myWorkoutVM.sheetEditLap) { lap in
                MyWorkoutEditLapView(workout: myWorkoutVM.workout, lap: lap)
                    .presentationDetents([.height(220)])
                    .presentationDragIndicator(.visible)
            }
            
            .sheet(isPresented: $isPresented,
                   content: {
                EditMyWorkoutSingleView(workout: myWorkoutVM.workout)
                .presentationDragIndicator(.visible)
            })
        }
    }
}

struct ListEditButton: View {
    let action: () -> Void
    
    var body: some View {
        Button("Edit", action: action)
            .tint(.yellowEdit)
    }
}

struct TextFieldTitle: View {
    @Bindable var myWorkoutVM: MyWorkoutViewModel
    @FocusState private var isTitleFocused
    
    var body: some View {
        TextField("", text: $myWorkoutVM.workout.name)
            .font(.largeTitle)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(clearGray)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
            .focused($isTitleFocused)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            isTitleFocused.toggle()
                        }
                    }
                }
            }
    }
}

#Preview {
    let container = DataController.previewContainer

    return NavigationStack {
        MyWorkoutView(myWorkoutVM: MyWorkoutViewModel(workout: Workout.getWorkout()))
            .modelContainer(container)
    }
    .tint(.white)
}
