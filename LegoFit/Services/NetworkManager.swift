//
//  NetworkManager.swift
//  LegoFit
//
//  Created by Denis Denisov on 30/5/24.
//

import Foundation

enum NetworkError: Error {
    case noData
    case invalidURL
    case decodingError
    case invalidResponse
    
    var description: String {
        switch self {
        case .noData:
            "Missing Data"
        case .invalidURL:
            "Invalid URL"
        case .decodingError:
            "Decoding Error"
        case .invalidResponse:
            "Invalid Response from server"
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchExercise() async throws -> [ExerciseDTO] {
        guard let url = URL(string: API.exercises.url) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        do {
            return try decoder.decode([ExerciseDTO].self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
