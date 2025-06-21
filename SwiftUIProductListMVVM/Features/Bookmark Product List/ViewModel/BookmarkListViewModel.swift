//
//  BookmarkListViewModel.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

import Foundation
import Combine

@MainActor
final class BookmarkListViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case loaded(products: [Product])
        case empty
        case error(message: String)
    }
    
    @Published var state: State = .idle
    
    private let bookmarkService: BookmarkServiceProtocol
    private let productRepository: ProductRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(
        bookmarkService: BookmarkServiceProtocol,
        productRepository: ProductRepositoryProtocol
    ) {
        self.bookmarkService = bookmarkService
        self.productRepository = productRepository
        setupObservers()
    }
    
    /// Observes changes in the bookmark set and reloads the product list accordingly.
    private func setupObservers() {
        bookmarkService.bookmarksPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.loadBookmarkedProducts()
            }
            .store(in: &cancellables)
    }
    
    /// Loads bookmarked products.
    func loadBookmarkedProducts() {
        guard !isLoading else { return }
        
        state = .loading
        
        Task {
            do {
                let bookmarkedIds = bookmarkService.bookmarks
                
                guard !bookmarkedIds.isEmpty else {
                    state = .empty
                    return
                }
                
                /// Fetch and filter bookmark products list.
                let allProducts = try await productRepository.getAllProducts()
                let bookmarkedProducts = allProducts.filter { bookmarkedIds.contains($0.id) }
                
                state = bookmarkedProducts.isEmpty ? .empty : .loaded(products: bookmarkedProducts)
            } catch {
                state = .error(message: error.localizedDescription)
            }
        }
    }
    
    private var isLoading: Bool {
        if case .loading = state { return true }
        return false
    }
    
    /// Toggles bookmark status for the product.
    func toggleBookmark(for product: Product) {
        bookmarkService.toggleBookmark(for: product)
    }
}

