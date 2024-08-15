//
//  ActiveWorkoutFinishView.swift
//  LegoFit
//
//  Created by Denis Denisov on 15/8/24.
//

import SwiftUI

struct ActiveWorkoutFinishView: View {
    @Binding var input: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            Text("Congratulations you did it!")
            TextField("Comment", text: $input)
            Button("Exit", action: action)
        }
    }
}

#Preview {
    ZStack {
        MainGradientBackground()
        VStack {
            ActiveWorkoutFinishView(input: .constant(""), action: {})
        }
    }
}
