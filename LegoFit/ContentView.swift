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
            
            HistoryWorkoutView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("History")
                }
        }
        .tint(.white)
    }
}

#Preview {
    ContentView()
        .modelContainer(DataController.previewContainer)
}
