//
//  Endpoint.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

import Foundation

enum APIConfig {
    static let scheme = "https"
    static let host = "dummyjson.com"
}

enum Endpoint {
    case products
    
    var path: String {
        switch self {
        case .products : return "/products"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .products:
            return .GET
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = APIConfig.scheme
        components.host = APIConfig.host
        components.path = path
        return components.url
    }
}
