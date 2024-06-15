//
//  LegoFitApp.swift
//  LegoFit
//
//  Created by Denis Denisov on 28/5/24.
//

import SwiftUI
import SwiftData

@main
struct LegoFitApp: App {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .modelContainer(for: [Workout.self])
        }
    }
}
