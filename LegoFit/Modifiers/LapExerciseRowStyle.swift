//
//  LapExerciseRowStyle.swift
//  LegoFit
//
//  Created by Denis Denisov on 26/7/24.
//

import SwiftUI

struct LapExerciseRowStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .listRowBackground(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(.main)
                    .opacity(0.1)
            )
    }
}
