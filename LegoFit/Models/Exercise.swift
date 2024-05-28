//
//  Exercise.swift
//  LegoFit
//
//  Created by Denis Denisov on 28/5/24.
//

import Foundation
import SwiftData

@Model
final class Exercise {
    let id: UUID
    let category: String
    let name: String
    let definition: String
    let photo: String
    
    init(id: UUID = UUID(), category: String, name: String, definition: String, photo: String) {
        self.id = id
        self.category = category
        self.name = name
        self.definition = definition
        self.photo = photo
    }
}
