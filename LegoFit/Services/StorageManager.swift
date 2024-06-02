//
//  StorageManager.swift
//  LegoFit
//
//  Created by Denis Denisov on 31/5/24.
//

import SwiftData

final class StorageManager {
static let shared = StorageManager()

func save(workout: Workout, context: ModelContext) {
    context.insert(workout)
    do {
        try context.save()
    } catch {
        print(error)
    }
}

func delete(workout: Workout, context: ModelContext) {
    context.delete(workout)
}

private init() {}
    
}
