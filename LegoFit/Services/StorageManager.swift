//
//  StorageManager.swift
//  LegoFit
//
//  Created by Denis Denisov on 31/5/24.
//

import SwiftUI
import SwiftData

final class StorageManager {
    @Environment(\.modelContext) var modelContext
    
    static let shared = StorageManager()
    
    func save(workout: Workout) {
        modelContext.insert(workout)
    }
    
    func delete(workout: Workout) {
        modelContext.delete(workout)
    }
    
//    func edit(workout: Workout) {
//        
//    }
    
    private init() {}
}
