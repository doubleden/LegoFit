//
//  ExerciseFromApi.swift
//  LegoFit
//
//  Created by Denis Denisov on 28/5/24.
//

import SwiftData

struct ExerciseFromApi: Decodable, Identifiable {
    let id: Int
    let category: String
    let name: String
    let description: String
    let image: String
}
