//
//  LabelGradientBackground.swift
//  LegoFit
//
//  Created by Denis Denisov on 15/6/24.
//

import SwiftUI

struct LabelGradientBackground<Content: View>: View {
    let content: Content
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(Gradient(colors: [.gray.opacity(0.3), .rose]))
                .opacity(0.8)
            .frame(width: 360, height: 40)
            .shadow(color: .night, radius: 10, y: 10)
            
            content
        }
    }
}

#Preview {
    LabelGradientBackground(content: Text("Check"))
}
