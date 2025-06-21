//
//  ProductListViewModel.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

import Foundation

@MainActor
final class ProductListViewModel: ObservableObject {
    
    struct ProductSection : Identifiable, Equatable {
        let id = UUID()
        let category: String
        let products: [Product]
    }
    
    enum State {
        case idle
        case loading
        case loaded(sections: [ProductSection])
        case error(message: String)
    }
    
    @Published  var state: State = .idle
    
    private let bookmarkService: BookmarkServiceProtocol
    private let productRepository: ProductRepositoryProtocol
    
    init(bookmarkService: BookmarkServiceProtocol, repository: ProductRepositoryProtocol) {
        self.bookmarkService = bookmarkService
        self.productRepository = repository
    }
    
    private var isLoading: Bool {
        if case .loading = state {
            return true
        }
        return false
    }
    
    func loadProducts() async {
        guard !isLoading else { return }
        state = .loading
        
        do {
            let products = try await productRepository.getAllProducts()
            processProducts(products)
        } catch {
            state = .error(message: error.localizedDescription)
        }
    }
    
    private func processProducts(_ products: [Product]) {
        let groupProductsByCategory = Dictionary(grouping: products) { $0.category }
        let sortedCategories = groupProductsByCategory.keys.sorted(by: <)
        let sections = sortedCategories.map { category in
            ProductSection(category: category, products: groupProductsByCategory[category] ?? [])
        }
        state = .loaded(sections: sections)
    }
    
    func toggleBookmark(for product: Product) {
        bookmarkService.toggleBookmark(for: product)
    }
}
