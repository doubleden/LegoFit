//
//  GradientBackground.swift
//  LegoFit
//
//  Created by Denis Denisov on 15/6/24.
//

import SwiftUI

struct GradientBackground<Content: View>: View {
    let content: Content
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(Gradient(colors: [.main, .violet]))
            .frame(width: 360, height: 60)
            
            content
        }
    }
}

#Preview {
    GradientBackground(content: Text("Check"))
}
