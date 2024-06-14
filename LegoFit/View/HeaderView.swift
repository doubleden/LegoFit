//
//  HeaderView.swift
//  LegoFit
//
//  Created by Denis Denisov on 14/6/24.
//

import SwiftUI

struct HeaderView: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(.main)
                .frame(maxHeight: .infinity)
                .frame(width: 360)
                .opacity(0.8)
            HStack {
                Text(text)
                    .foregroundStyle(.white)
                    .font(.system(size: 22))
                    .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    HeaderView(text: "Legs")
}
