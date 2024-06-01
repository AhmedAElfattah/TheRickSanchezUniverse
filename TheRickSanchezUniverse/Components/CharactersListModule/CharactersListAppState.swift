//
//  CharactersListAppStateData.swift
//  TheRickSanchezUniverse
//
//  Created by Ahmed MAbdelfattah on 30/05/2024.
//

import Foundation


enum CharactersListAppState: Equatable {
    static func == (lhs: CharactersListAppState, rhs: CharactersListAppState) -> Bool {
        switch (lhs, rhs) {
        case (initial, initial):
            return true
        case (loading, loading):
            return true
        case (failure, failure):
            // TODO: Check for different types of errors when matching
            return true
        case let (success(charactersList: charactersList), success(charactersList: charactersList2)):
            return charactersList2 == charactersList
        default:
            return false
        }
    }
    
    case initial
    case loading
    case success(charactersList: [CharacterRepresentation])
    case failure
}



struct CharacterRepresentation: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: String
}

extension CharacterRepresentation {
    init(from characterResponse: CharactersInfoObject) {
        self.id = characterResponse.id
        self.gender = characterResponse.gender
        self.image = characterResponse.image
        self.name = characterResponse.name
        self.species = characterResponse.species
        self.status = characterResponse.status
        self.location = characterResponse.location.name
    }
}
