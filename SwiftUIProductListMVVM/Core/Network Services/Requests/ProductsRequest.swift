//
//  ProductsRequest.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

import Foundation

struct ProductsRequest: APIRequest {
    
    typealias Response = ProductRespone
   
    private let endpoint: Endpoint = .products
    
    var urlRequest: URLRequest {
        guard let url = endpoint.url else {
            preconditionFailure("Invalid URL for endpoint : \(endpoint)")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        return request
    }
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    } 
}
