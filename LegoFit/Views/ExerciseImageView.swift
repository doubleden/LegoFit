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
                Image(systemName: "questionmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 30)
            }
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ExerciseImageView(imageUrl: Exercise.getExercises().first!.image)
}
