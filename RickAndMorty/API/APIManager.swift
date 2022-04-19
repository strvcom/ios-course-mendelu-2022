//
//  APIManager.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import Foundation

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
    
    private lazy var decoder = JSONDecoder()
    
    func request<T>(urlString: String) async throws -> T where T : Decodable {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidUrlComponents
        }
        
        let request = URLRequest(url: url)
        Logger.log("Request for \(request.description)")
        
        let (data, response) = try await urlSession.data(for: request)
        
        Logger.log("Response \(response)")
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.noResponse
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw APIError.unacceptableResponseStatusCode
        }
        
        let object = try decoder.decode(T.self, from: data)
        
        return object
    }
}
