//
//  Devider.swift
//  LegoFit
//
//  Created by Denis Denisov on 23/7/24.
//

import SwiftUI

struct Divider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.main)
            .shadow(color: .main, radius: 5, y: 2)
    }
}

#Preview {
    Divider()
}
