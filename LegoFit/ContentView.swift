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
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.cosmos, for: .tabBar)
            
            HistoryWorkoutView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("History")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.cosmos, for: .tabBar)
        }
        .tint(.white)
    }
}

#Preview {
    ContentView()
        .modelContainer(DataController.previewContainer)
}
