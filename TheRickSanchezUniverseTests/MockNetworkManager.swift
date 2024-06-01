//
//  MockNetworkManager.swift
//  TheRickSanchezUniverseTests
//
//  Created by Ahmed MAbdelfattah on 31/05/2024.
//

import Foundation
@testable import TheRickSanchezUniverse

class MockNetworkManager: NetworkManagerDictatable {
    func fetchCharacters(url: String, page: Int, status: String?, completion: @escaping (TheRickSanchezUniverse.NetworkResponse) -> Void) {
        guard let path = Bundle(for: type(of: self)).path(forResource: url, ofType: "json") else {
            completion(.failure(error: .noData))
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decodedResponse = try JSONDecoder().decode([CharactersInfoObject].self, from: data)
            completion(.success(decodedResponse))
        } catch {
            completion(.failure(error: .decodingFailure))
        }
    }
    
    var mockCharacters: [CharacterRepresentation] = []
    
    
}

