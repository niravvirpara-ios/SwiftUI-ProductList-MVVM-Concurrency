//
//  BookmarkListDIContainer.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

import SwiftUI

/// Dependency Injection container for the Bookmark List feature.
@MainActor
final class BookmarkListDIContainer {
    
    private let bookmarkService: BookmarkServiceProtocol
    private let productRepository: ProductRepositoryProtocol
    
    init(bookmarkService: BookmarkServiceProtocol,
         productRepository: ProductRepositoryProtocol) {
        self.bookmarkService = bookmarkService
        self.productRepository = productRepository
    }
     
    /// Create the ViewModel for the BookmarkListView.
    func makeViewModel() -> BookmarkListViewModel {
        BookmarkListViewModel(
            bookmarkService: bookmarkService,
            productRepository: productRepository
        )
    }
 
    /// Create the BookmarkListView with injected ViewModel.
    func makeView() -> some View {
        BookmarkListView(viewModel: makeViewModel())
    }
}
