//
//  BadgeView.swift
//  LegoFit
//
//  Created by Denis Denisov on 22/8/24.
//

import SwiftUI

struct BadgeView: View {
    let number: Int
    
    var body: some View {
        Text(number.formatted())
            .font(.caption2)
            .foregroundColor(.black)
            .frame(width: 20)
            .background(.yellow)
            .clipShape(Circle())
    }
}

#Preview {
    BadgeView(number: 2)
}
