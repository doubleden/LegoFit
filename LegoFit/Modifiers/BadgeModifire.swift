//
//  BadgeModifire.swift
//  LegoFit
//
//  Created by Denis Denisov on 22/8/24.
//

import SwiftUI

struct BadgeModifire: ViewModifier {
    let quantity: Int
    var isForTitle = false
    
    func body(content: Content) -> some View {
        content
            .overlay(
                quantity > 0
                ? AnyView(BadgeView(number: quantity)
                    .offset(x: isForTitle ? 7 : 0, y: isForTitle ? -6 : 0)) 
                : AnyView(Circle().opacity(0))
                , alignment: .topTrailing
            )
    }
}
