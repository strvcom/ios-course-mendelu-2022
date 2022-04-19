//
//  CharacterDetailStore.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import CoreData

// TODO: Repeat @MainActor
// TODO: Repeat store states, @Published, @StateObject
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
   
    @Injected var apiManager: APIManaging
    
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
    
    // TODO: 1) Repeat async await syntax
    /// download all episodes from
    func load() async {
         // await fetchEpisodes()
    }
    
    // TODO: 1) write fetchEpisodes 
    /// Check wheater the character is set
    /// withThrowingTaskGroup
    /// explain why we return Episode
    /// add episodes to array
    /// check log - error parsing date
    
}

// MARK: - Fetching
private extension CharacterDetailStore {}
