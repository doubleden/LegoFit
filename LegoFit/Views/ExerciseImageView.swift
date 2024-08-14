//
//  ExerciseImageView.swift
//  LegoFit
//
//  Created by Denis Denisov on 1/6/24.
//

import SwiftUI
import Kingfisher

struct ExerciseImageView: View {
    let imageUrl: String
    
    var body: some View {
        KFImage(URL(string: imageUrl))
            .placeholder {
                Image("placeholderImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 30)
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: 300, maxHeight: 250)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .indigo, radius: 5)
    }
}

#Preview {
    ExerciseImageView(imageUrl: Exercise.getExercises().first!.image)
}
