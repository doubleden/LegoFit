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
    
    func badge(quantity: Int, isForTitle: Bool = false) -> some View {
        modifier(BadgeModifire(quantity: quantity, isForTitle: isForTitle))
    }
    
    func startVibrationSuccess() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    
    func startVibration() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    func startRattleVibration() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        
        let numberOfVibrations = 5
        let interval: TimeInterval = 0.1
        
        for i in 0..<numberOfVibrations {
            DispatchQueue.main.asyncAfter(deadline: .now() + (interval * Double(i))) {
                generator.impactOccurred()
            }
        }
    }
}
