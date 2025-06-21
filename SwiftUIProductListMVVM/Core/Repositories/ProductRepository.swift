//
//  ProductRepository.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

protocol ProductRepositoryProtocol {
    func getProduct(id: Int) async throws -> Product?
    func getAllProducts() async throws -> [Product]
}

final class ProductRepository: ProductRepositoryProtocol {
    
    private let apiService: APIServiceProtocol
    private var productList: [Product] = []
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    /// Returns a product by ID. Fetches from API if cache is empty.
    func getProduct(id: Int) async throws -> Product? {
        if productList.isEmpty {
            try await loadProducts()
        }
        return productList.first { $0.id == id }
    }
    
    /// Returns all products.
    func getAllProducts() async throws -> [Product] {
        if productList.isEmpty {
            try await loadProducts()
        }
        return productList
    }
    
    /// Loads products from the API and updates product list.
    func loadProducts() async throws {
        let response = try await apiService.execute(ProductsRequest())
        productList = response.products
    } 
}
