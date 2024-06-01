//
//  ContentView.swift
//  LegoFit
//
//  Created by Denis Denisov on 28/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CreateWorkoutView(createWorkoutVM: CreateWorkoutViewViewModel())
                .tabItem {
                    
                    Text("Create")
                }
            
            MyWorkoutsView()
                .tabItem {
                    
                    Text("My workouts")
                }
        }
    }
}

#Preview {
    ContentView()
}
