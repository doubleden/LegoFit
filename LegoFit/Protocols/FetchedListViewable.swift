//
//  File.swift
//  LegoFit
//
//  Created by Denis Denisov on 6/8/24.
//

protocol FetchedListViewable {
    var workout: Workout { get set }
    var sheetExercise: Exercise? { get set }
    var isAddingLap: Bool { get set }
    func add(exercise: Exercise)
}
