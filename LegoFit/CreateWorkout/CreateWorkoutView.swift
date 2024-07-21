//
//  CreateWorkoutView.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import SwiftUI

struct CreateWorkoutView: View {
    @State private var createWorkoutVM = CreateWorkoutViewModel()
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @FocusState private var IsFocused: Bool
    
    var body: some View {
        ZStack {
            MainGradientBackground()
                .ignoresSafeArea()
                .onTapGesture {
                    IsFocused = false
                }
            VStack {
                if createWorkoutVM.isAddingLap {
                    ElementsForInteractWithLap(
                        createWorkoutVM: $createWorkoutVM,
                        IsFocused: $IsFocused
                    )
                }
                
                FetchedExerciseListView(createWorkoutVM: $createWorkoutVM)
            }
            .padding(.top, 20)
            
            // MARK: - Sheets
            // Экран с описание упражнения
            .sheet(item: $createWorkoutVM.sheetExercise) { exercise in
                CreateWorkoutDetailsView(createWorkoutVM: $createWorkoutVM)
                    .presentationBackground(.black)
                    .presentationDragIndicator(.visible)
            }
            .onChange(of: createWorkoutVM.sheetExercise, {
                if IsFocused {
                    IsFocused = false
                }
            })
            
            // Экран сохранения
            .sheet(isPresented: $createWorkoutVM.isSaveSheetPresented,
                   onDismiss: {
                if createWorkoutVM.isDidSave {
                    dismiss()
                }
            }) {
                CreateWorkoutSaveView( createWorkoutVM: createWorkoutVM ) .presentationDragIndicator(.visible)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Exercises")
        .navigationBarTitleDisplayMode(.inline)
        
        // MARK: - ToolBar
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ButtonToolbar(
                    title: "Cancel",
                    action: {
                        createWorkoutVM.cancelCreateWorkout(
                            modelContext: modelContext
                        )
                        dismiss()
                    }
                )
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    if createWorkoutVM.isAddingLap {
                        IsFocused = false
                        createWorkoutVM.clearLapInputs()
                    } else {
                        IsFocused = true
                    }
                    withAnimation(.smooth) {
                        createWorkoutVM.isAddingLap.toggle()
                    }
                }, label: {
                    Image(systemName: createWorkoutVM.isAddingLap ? "figure.run.square.stack.fill" : "figure.run.square.stack")
                        .tint(.main)
                })
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                ButtonToolbar(title: "Workout") {
                    createWorkoutVM.isSaveSheetPresented.toggle()
                }
                .disabled(createWorkoutVM.isExercisesInWorkoutEmpty())
                
            }
            
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button("Done") {
                        IsFocused.toggle()
                    }
                }
            }
        }
        
        // MARK: - Alerts
        .alert(createWorkoutVM.errorMessage ?? "",
               isPresented: $createWorkoutVM.isAlertPresented) {
            Button("Ok", role: .cancel) {}
        }
        
        .onAppear {
            createWorkoutVM.fetchExercises()
        }
        
        .onDisappear {
            createWorkoutVM.isAddingLap = false
        }
    }
}
// MARK: - List
fileprivate struct FetchedExerciseListView: View {
    @Binding var createWorkoutVM: CreateWorkoutViewModel
    
    var body: some View {
        List(
            Array(createWorkoutVM.sortedByCategoryExercises.keys.sorted()),
            id: \.self
        ) { section in
            Section(section) {
                ForEach(
                    createWorkoutVM.sortedByCategoryExercises[section] ?? []
                ) { exercise in
                    Button(action: {
                        createWorkoutVM.showSheetOf(exercise: exercise)
                    }, label: {
                        Text(exercise.name)
                            .foregroundStyle(.white)
                            
                    })
                    .swipeActions(edge: .leading, allowsFullSwipe:true) {
                        Button(action: {
                            createWorkoutVM.add(exercise: exercise)
                        }, label: {
                            Image(systemName: "plus.circle.dashed")
                        })
                        .tint(.main)
                    }
                    .mainRowStyle()
                }
            }
        }
        .mainListStyle()
        .background(
            MainGradientBackground()
        )
        .refreshable {
            createWorkoutVM.fetchExercises()
        }
    }
}

// MARK: - Элементы для Lap
fileprivate struct ElementsForInteractWithLap: View {
    @Binding var createWorkoutVM: CreateWorkoutViewModel
    @FocusState.Binding var IsFocused: Bool
    
    var body: some View {
        TextField("Quantity of laps", text: $createWorkoutVM.lapQuantity)
            .focused($IsFocused)
            .keyboardType(.numberPad)
            .padding()
            .frame(width: 170, height: 40)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.main)
            )
            .onTapGesture {
                IsFocused = false
            }
        
        CircleButton(
            icon: Image(systemName: "plus"),
            width: 50,
            height: 50,
            isDisable: !createWorkoutVM.isLapValid()
        ) {
            createWorkoutVM.addToWorkoutLap()
            withAnimation(.smooth) {
                createWorkoutVM.isAddingLap.toggle()
                IsFocused = false
            }
        }
        .padding(
            EdgeInsets(
                top: 5,
                leading: 0,
                bottom: 10,
                trailing: 0
            )
        )
    }
}

import SwiftData
#Preview {
    let container = DataController.previewContainer
    
    return NavigationStack {
        CreateWorkoutView()
            .modelContainer(container)
    }
}
