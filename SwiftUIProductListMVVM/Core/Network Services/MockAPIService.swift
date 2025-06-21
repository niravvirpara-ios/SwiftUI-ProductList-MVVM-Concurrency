//
//  MockAPIService.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

import Foundation

final class MockAPIService: APIServiceProtocol {
    
    var shouldSucceed: Bool = true
    
    var mockProducts: [Product] = [
        Product(
            id: 1,
            title: "Essence Mascara Lash Princess",
            description: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.",
            category: "beauty",
            thumbnail: "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/1.webp",
            availabilityStatus: "In Stock",
            price: 9.99,
            stock: 99
        )
    ]
    
    func execute<T: APIRequest>(_ request: T) async throws -> T.Response {
        try await Task.sleep(nanoseconds: 500_000_000)
        
        guard shouldSucceed else {
            throw URLError(.cannotConnectToHost)
        }
        
        if let productRequest = request as? ProductsRequest {
            return try handleProductRequest(productRequest) as! T.Response
        }
        
        throw URLError(.unsupportedURL)
    }
    
    private func handleProductRequest<T: APIRequest>(_ request: T) throws -> ProductRespone {
        return ProductRespone(products: mockProducts)
    }
}
