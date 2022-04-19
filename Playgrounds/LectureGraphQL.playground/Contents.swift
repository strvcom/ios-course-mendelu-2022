import UIKit
import Apollo

// Rick and morty API Playground - https://rickandmortyapi.com/graphql

// TODO: Graphql 1 - Show how does code gen work

// TODO: Graphql 2 - Create Client
let normalizedCache = InMemoryNormalizedCache()

let apolloStore = ApolloStore(cache: normalizedCache)

let interceptorProvider = DefaultInterceptorProvider(store: apolloStore)

let endpointURL = URL(string: "https://rickandmortyapi.com/graphql")!

let networkTransport = RequestChainNetworkTransport(
    interceptorProvider: interceptorProvider,
    endpointURL: endpointURL
)

let client = ApolloClient(
    networkTransport: networkTransport,
    store: apolloStore
)

// TODO: Graphql 2 - Fetch query

let query = CharactersQuery()

client.fetch(
    query: query,
    cachePolicy: .fetchIgnoringCacheCompletely,
    queue: .main,
    resultHandler: { result in
        print(result)
        switch result {
        case let .success(data):
            print(data)
        case let .failure(error):
            print("💔 Error received when performing fetch", error)
        }
    }
)

// TODO: Graphql 3 - Play with generated query
