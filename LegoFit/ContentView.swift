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
            MyWorkoutsView()
                .tabItem {
                    Image(systemName: "dumbbell")
                    Text("My workouts")
                }
            CreateWorkoutView()
                .tabItem {
                    Image(systemName: "plus.square.dashed")
                    Text("Creat")
                }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
