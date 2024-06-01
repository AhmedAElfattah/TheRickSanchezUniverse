//
//  NetworkManager.swift
//  TheRickSanchezUniverse
//
//  Created by Ahmed MAbdelfattah on 30/05/2024.
//

import Foundation

enum NetworkError {
    case invalidURL
    case decodingFailure
    case noData
    case networkError(description: String)
}

enum NetworkResponse {
    case success([CharactersInfoObject])
    case failure(error: NetworkError)
}

protocol NetworkManagerDictatable {
    func fetchCharacters(url: String, page: Int, status: String?, completion: @escaping (NetworkResponse) -> Void)
}


class NetworkManager: NetworkManagerDictatable {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchCharacters(url: String, page: Int, status: String?, completion: @escaping (NetworkResponse) -> Void) {
        guard var urlComponents = URLComponents(string: url) else {
            completion(.failure(error: .invalidURL))
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        if let status = status {
            urlComponents.queryItems?.append(URLQueryItem(name: "status", value: status))
        }
        
        let url = urlComponents.url!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error: .networkError(description: error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(error: .noData))
                return
            }
            
            do {
                let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                completion(.success(characterResponse.results))
            } catch {
                completion(.failure(error: .decodingFailure))
            }
        }.resume()
    }
}
