//
//  ExercisesFromDataBase.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import Foundation
import SwiftData

@Model
final class ExercisesFromDataBase {
    let id: Int
    let category: String
    let name: String
    let definition: String
    let photo: String
    
    var set = 0
    var rep = 0
    var weight = 0
    
    init(id: Int, category: String, name: String, definition: String, photo: String) {
        self.id = id
        self.category = category
        self.name = name
        self.definition = definition
        self.photo = photo
    }
}
