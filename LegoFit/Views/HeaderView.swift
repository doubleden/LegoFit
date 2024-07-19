//
//  HeaderView.swift
//  LegoFit
//
//  Created by Denis Denisov on 14/6/24.
//

import SwiftUI

struct HeaderView: View {
    let text: String
    @Binding var isLoading: Bool
    
    var body: some View {
        ZStack {
            LabelGradientBackground(content:
                HStack {
                    Text(text)
                        .foregroundStyle(.white)
                        .font(.title2)
                        .padding()
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    Spacer()
                }
            )
        }
    }
}

#Preview {
    HeaderView(text: "Legs", isLoading: .constant(true))
}
