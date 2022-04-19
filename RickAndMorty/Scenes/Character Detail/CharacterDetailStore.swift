//
//  CharacterDetailStore.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import CoreData

@MainActor final class CharacterDetailStore: NSObject, ObservableObject {
    enum State: Equatable {
        case initial
        case loading
        case finished
        case failed
    }
    
    @Published var state: State = .initial
    @Published var character: Character?
    @Published var episodes: [Episode] = .init()
    @Published var isLiked: Bool = false
   
    let providedData: ProvidedData<Character>
    
    init(providedData: ProvidedData<Character>) {
        self.providedData = providedData
        
        super.init()
        
        if case let .entity(character) = providedData {
            self.character = character
            
            state = .finished
        }
    }
}

// MARK: - Actions
extension CharacterDetailStore {
    
    func load() async {

    }
}

// MARK: - Fetching
private extension CharacterDetailStore {}
