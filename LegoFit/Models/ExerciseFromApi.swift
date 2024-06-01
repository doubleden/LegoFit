//
//  ExerciseFromApi.swift
//  LegoFit
//
//  Created by Denis Denisov on 28/5/24.
//

struct ExerciseFromApi: Decodable, Identifiable {
    let id: Int
    let category: String
    let name: String
    let description: String
    let image: String
    
    static func getExercise() -> ExerciseFromApi {
        ExerciseFromApi(id: 2, category: "legs", name: "De", description: "jnsdn", image: "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg")
    }
}
