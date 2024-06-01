//
//  UIActivityIndicatorRepresentation.swift
//  LegoFit
//
//  Created by Denis Denisov on 31/5/24.
//

import SwiftUI

struct UIActivityIndicatorRepresentation: UIViewRepresentable {
    var isAnimating: Bool
    
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<UIActivityIndicatorRepresentation>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<UIActivityIndicatorRepresentation>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
