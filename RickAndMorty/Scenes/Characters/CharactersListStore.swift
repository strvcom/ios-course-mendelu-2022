//
//  CharactersListStore.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation

@MainActor
final class CharactersListStore: ObservableObject {
    enum State: Equatable {
        case initial
        case loading
        case finished(loadingMore: Bool)
        case failed
    }
    
    @Published var state: State = .initial
    @Published var characters: [Character] = .init()
    
    private var currentResponseInfo: PaginationInfo? = nil
    @Injected private var apiManager: APIManaging
}

// MARK: - Actions
extension CharactersListStore {
    func load() async {
        state = .loading
        
        await fetch()
    }
}

// MARK: - Fetching
private extension CharactersListStore {
    
    func fetch() async {
        let urlString = "https://rickandmortyapi.com/api/character"
        
        do {
            
            let object: PaginatedResponse<Character> = try await apiManager.request(urlString: urlString)
            
            characters += object.results
            
            state = .finished(loadingMore: false)
            
        } catch {
            Logger.log("UrlSessionError \(error)")
            state = .failed
        }
    }
}
