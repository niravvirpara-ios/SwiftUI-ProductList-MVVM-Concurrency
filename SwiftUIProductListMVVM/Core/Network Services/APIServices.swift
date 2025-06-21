//
//  APIServices.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

import Foundation

/// Protocol defining the requirements for any API request.
protocol APIRequest {
    associatedtype Response: Decodable
    var urlRequest: URLRequest { get }
    var decoder: JSONDecoder { get }
}

protocol APIServiceProtocol {
    func execute<T: APIRequest>(_ request: T) async throws -> T.Response
}

final class APIService: APIServiceProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func execute<T: APIRequest>(_ request: T) async throws -> T.Response {
        let (data, response) = try await session.data(for: request.urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            do {
                return try request.decoder.decode(T.Response.self, from: data)
            } catch {
                throw APIError.decodingFailed
            } 
        case 400...499:
            throw APIError.clientError(statusCode: httpResponse.statusCode)
        case 500...599:
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        default:
            throw APIError.unknown
        }
    }
}
