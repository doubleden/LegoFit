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
                .foregroundStyle(Gradient(colors: [.main, .cellBackground]))
                .frame(width: 360, height: 60)
            HStack {
                Text(text)
                    .foregroundStyle(.white)
                    .font(.title2)
                    .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    HeaderView(text: "Legs")
}
