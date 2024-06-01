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
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 250)
            .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    ExerciseImageView(imageUrl: ExerciseFromApi.getExercise().image)
}
