//
//  ResponseModelsRepresentation.swift
//  TheRickSanchezUniverse
//
//  Created by Ahmed MAbdelfattah on 30/05/2024.
//

import Foundation

struct CharacterResponse: Codable {
    let results: [CharactersInfoObject]
}
struct Location: Codable {
    let name: String
}

struct CharactersInfoObject: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: Location
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case status
        case species
        case gender
        case image
        case location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(String.self, forKey: .status)
        self.species = try container.decode(String.self, forKey: .species)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.image = try container.decode(String.self, forKey: .image)
        self.location = try container.decode(Location.self, forKey: .location)
    }
}
