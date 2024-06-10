//
//  NetworkManager.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import Foundation

enum API {
    case exercises
    
    var url: URL {
        switch self {
        case .exercises:
            URL(string: "http://192.168.18.234:8080/trainings")!
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
    
    func fetchExercises(from url: URL, completion: @escaping(Result<[ExerciseDTO], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Request error: \(error.localizedDescription)")
                completion(.failure(.noData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response")
                completion(.failure(.invalidURL))
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(.noData))
                return
            }
            
            do {
                let exercises = try JSONDecoder().decode([ExerciseDTO].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(exercises))
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
