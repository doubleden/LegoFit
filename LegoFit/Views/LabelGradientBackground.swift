//
//  LabelGradientBackground.swift
//  LegoFit
//
//  Created by Denis Denisov on 15/6/24.
//

import SwiftUI

struct LabelGradientBackground<Content: View>: View {
    var width: CGFloat = 360
    let content: Content
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(Gradient(colors: [.gray.opacity(0.3), .orange]))
                .opacity(0.8)
            .frame(width: width, height: 40)
            
            content
        }
    }
}

#Preview {
    LabelGradientBackground(content: Text("Check"))
}
