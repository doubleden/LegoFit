//
//  ContentView.swift
//  LegoFit
//
//  Created by Denis Denisov on 28/5/24.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MyWorkoutsView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "dumbbell")
                    Text("Мои тренировки")
                }
                .tag(0)
            
            CreateWorkoutView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "plus.square.dashed")
                    Text("Создать")
                }
                .tag(1)
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
