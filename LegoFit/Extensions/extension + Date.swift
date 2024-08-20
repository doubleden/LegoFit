//
//  extension + Date.swift
//  LegoFit
//
//  Created by Denis Denisov on 20/8/24.
//

import Foundation

extension Date {
    func showDate() -> String {
        self.formatted(date: .abbreviated, time: .omitted)
    }
}
