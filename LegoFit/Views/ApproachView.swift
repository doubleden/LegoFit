//
//  ApproachView.swift
//  LegoFit
//
//  Created by Denis Denisov on 16/8/24.
//

import SwiftUI

struct ApproachView: View {
    let text: String
    let completedApproach: Int
    let approach: Int
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(text)
            HStack {
                Text(completedApproach.formatted())
                    .foregroundStyle(completedApproach == 0 ? .white : .venom)
                Text("of")
                Text(approach.formatted())
            }
            .font(.system(size: 50))
            .frame(minWidth: 150, alignment: .trailing)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    ApproachView(text: "laps done", completedApproach: 2, approach: 2)
}
