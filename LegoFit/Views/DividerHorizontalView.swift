//
//  Devider.swift
//  LegoFit
//
//  Created by Denis Denisov on 23/7/24.
//

import SwiftUI

struct DividerHorizontalView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: 2)
            .foregroundStyle(.yellow)
            .shadow(color: .orange, radius: 5, y: 2)
    }
}

#Preview {
    DividerHorizontalView()
}
