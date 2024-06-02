//
//  NetworkManager.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import Foundation
import Alamofire

enum API {
    case exercises
    
    var url: URL {
        switch self {
        case .exercises:
            URL(string: "http://127.0.0.1:8080/trainings")!
        }
    }
}

enum NetworkError: Error {
    case noData
    case invalidURL
    case decodingError
    
    var description: String {
        switch self {
        case .noData:
            "Missing Data"
        case .invalidURL:
            "Invalid URL"
        case .decodingError:
            "Decoding Error"
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchExercises(from url: URL, completion: @escaping(Result<[ExerciseDTO], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: [ExerciseDTO].self) { response in
                switch response.result {
                case .success(let exercises):
                    completion(.success(exercises))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
