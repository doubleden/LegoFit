//
//  ToolBarButton.swift
//  LegoFit
//
//  Created by Denis Denisov on 14/6/24.
//

import SwiftUI

struct ButtonToolbar: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
        }
        .tint(.main)
    }
}

#Preview {
    ButtonToolbar(title: "Done", action: {})
}
