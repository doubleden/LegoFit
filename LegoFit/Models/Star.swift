//
//  Star.swift
//  LegoFit
//
//  Created by Denis Denisov on 18/8/24.
//

import Foundation

struct Star: Identifiable {
    let id = UUID()
    var symbol = "⭐️"
    var x: CGFloat
    var y = 0.0
    let size = CGFloat.random(in: 30...50)
    let duration = Double.random(in: 3...6)
}
