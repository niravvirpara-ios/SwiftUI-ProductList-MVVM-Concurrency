//
//  APIError.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

import Foundation

enum APIError: Error, LocalizedError { 
    case invalidURL
    case invalidResponse
    case decodingFailed
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case network(Error)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:                   return "Invalid URL"
        case .invalidResponse:              return "Invalid server response"
        case .decodingFailed:               return "Failed to decode response"
        case .clientError(let code):        return "Client error (\(code))"
        case .serverError(let code):        return "Server error (\(code))"
        case .network(let error):           return "Network error: \(error.localizedDescription)"
        case .unknown:                      return "Unknown error occurred"
        }
    }
}
