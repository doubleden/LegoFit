//
//  PreviewProviderSwiftData.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/6/24.
//

import Foundation
import SwiftData

@MainActor
class DataController {
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Workout.self, configurations: config)

            container.mainContext.insert(Workout.getWorkout())
            container.mainContext.insert(Workout.getWorkout())
            container.mainContext.insert(Workout.getWorkout())
            container.mainContext.insert(Workout.getWorkoutFinished())
            
            let workout2 = Workout.getWorkoutFinished()
            workout2.finishDate = Date.now.addingTimeInterval(-86400)
            workout2.name = "second"
            container.mainContext.insert(workout2)
            
            let workout3 = Workout.getWorkoutFinished()
            workout3.finishDate = Date.now.addingTimeInterval(-86400)
            workout3.name = "third"
            container.mainContext.insert(workout3)

            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}
