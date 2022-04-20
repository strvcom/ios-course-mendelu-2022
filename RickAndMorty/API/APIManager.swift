//
//  APIManager.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation

// TODO: 3) create HttpMethod, HttpHeader files in utilities folder
// TODO: 4) define Endpoint protocol + default implementation
// TODO: 5) create routers folder + router for characters & episodes
// TODO: 6) change api managing to Endpoint parameters + update app
// TODO: Extra) create service layer as in template in case we have time (separating of concept, we don't care about service type - cache, networking or both - adapted service


//// MARK: - Protocol
protocol APIManaging {
    func request<T: Decodable>(urlString: String) async throws -> T
}

// MARK: - Implementation
class APIManager: APIManaging {
    
    private lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return URLSession(configuration: configuration)
    }()
    
    // TODO: 2) Add DateFormatter to JsonDecoder
    /// explain formatter & decoder
    private lazy var decoder = JSONDecoder()
    
    func request<T>(urlString: String) async throws -> T where T : Decodable {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidUrlComponents
        }
        
        let request = URLRequest(url: url)
        Logger.log("Request for \(request.description)")
        
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.noResponse
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw APIError.unacceptableResponseStatusCode
        }
        
        // Uncomment this for pretty response logging!
        if let body = String(data: data, encoding: .utf8) {
            Logger.log("""
            ☀️ Response for \"\(request.description)\":
            👀 Status: \(httpResponse.statusCode)
            🧍‍♂️ Body:
            \(body)
            """)
        }
        
        let object = try decoder.decode(T.self, from: data)
        
        return object
    }
}
