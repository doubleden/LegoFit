//
//  ContentView.swift
//  LegoFit
//
//  Created by Denis Denisov on 28/5/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView() {
            MyWorkoutsView()
                .tabItem {
                    Image(systemName: "dumbbell")
                    Text("Мои тренировки")
                }
        }
        
        .tint(.cosmos)
    }
}

#Preview {
    ContentView()
        .modelContainer(DataController.previewContainer)
}
