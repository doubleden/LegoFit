//
//  LoadingView.swift
//  LegoFit
//
//  Created by Denis Denisov on 31/5/24.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Загрузка данных...")
            UIActivityIndicatorRepresentation(
                isAnimating: true,
                style: .large
            )
        }
    }
}

#Preview {
    LoadingView()
}
