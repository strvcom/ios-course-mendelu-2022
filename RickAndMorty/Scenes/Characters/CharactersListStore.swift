//
//  CharactersListStore.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation

// TODO: 4) show warning, solve by actor
final class CharactersListStore: ObservableObject {
    enum State: Equatable {
        case initial
        case loading
        case finished(loadingMore: Bool)
        case failed
    }
    
    // TODO: 6) injected api manager
    @Published var state: State = .initial
    @Published var characters: [Character] = .init()
    
    private var currentResponseInfo: PaginationInfo? = nil
}

// MARK: - Actions
extension CharactersListStore {
    // TODO: 1) write async method
    /// state = .loading
    func load() {
        state = .finished(loadingMore: false)
        characters.append(Character.mock)
    }
}

// MARK: - Fetching
private extension CharactersListStore {
    
    // TODO: 2) write async method which loads data from REST API
    /* Steps
        1) url we use "https://rickandmortyapi.com/api/character"
        2) url session
        3) receive data
        4) validate response
        5) parse data
     */
}
