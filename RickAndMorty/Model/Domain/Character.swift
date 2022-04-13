//
//  Character.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation
// TODO: Show
struct Character {
    let id: Int
    let name: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOrigin
    let location: CharacterLocation
    let imageUrl: URL
    let episodeUrls: [URL]
        
    var episodeIds: [Int] {
        episodeUrls
            .compactMap {
                Int($0.lastPathComponent)
            }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case species
        case type
        case gender
        case origin
        case location
        case imageUrl = "image"
        case episodeUrls = "episode"
    }
}

// MARK: - Conformances
extension Character: Identifiable {}
extension Character: Equatable {}
extension Character: Decodable {}

// MARK: - Mock
#if DEBUG
// TODO: Show
extension Character {
    static let mock: Character = .init(
        id: 1,
        name: "Rick Sanchez",
        species: "Human",
        type: "",
        gender: "Male",
        origin: .mock,
        location: .mock,
        imageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
        episodeUrls: [
            URL(string: "https://rickandmortyapi.com/api/episode/1")!,
            URL(string: "https://rickandmortyapi.com/api/episode/2")!
        ]
    )
}
#endif
