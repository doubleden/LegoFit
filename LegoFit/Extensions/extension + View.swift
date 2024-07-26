//
//  extension + View.swift
//  LegoFit
//
//  Created by Denis Denisov on 19/7/24.
//

import SwiftUI

extension View {
    func mainListStyle() -> some View {
            modifier(MainListStyle())
        }
    
    func mainRowStyle() -> some View {
        modifier(MainRowStyle())
    }
    
    func lapExerciseRowStyle() -> some View {
        modifier(LapExerciseRowStyle())
    }
}
