//
//  ExerciseImageView.swift
//  LegoFit
//
//  Created by Denis Denisov on 1/6/24.
//

import SwiftUI
import Kingfisher

//TODO: Сделать картинку по умолчанию если не загружается
//TODO: И Сделать ProgressView() пока картинка загружается
struct ExerciseImageView: View {
    let imageUrl: String
    
    var body: some View {
        KFImage(URL(string: imageUrl))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 200)
            .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    ExerciseImageView(imageUrl: ExerciseDTO.getExercise().image)
}
