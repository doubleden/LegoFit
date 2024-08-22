//
//  DividerVerticalView.swift
//  LegoFit
//
//  Created by Denis Denisov on 16/8/24.
//

import SwiftUI

struct DividerVerticalView: View {
    var body: some View {
        Rectangle()
            .frame(width: 4, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 50))
            .foregroundStyle(.black)
    }
}

#Preview {
    DividerVerticalView()
}
