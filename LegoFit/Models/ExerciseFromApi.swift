//
//  ExerciseFromApi.swift
//  LegoFit
//
//  Created by Denis Denisov on 28/5/24.
//

import SwiftData

struct ExerciseFromApi: Decodable {
    let id: Int
    let category: String
    let name: String
    let definition: String
    let photo: String
}
