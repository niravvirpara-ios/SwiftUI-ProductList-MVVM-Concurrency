//
//  ProductDetailsViewModel.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 15/06/25.
//

import Foundation

@MainActor
final class ProductDetailsViewModel: ObservableObject {
    
    private(set) var product: Product
    private let bookmarkService: BookmarkServiceProtocol
    
    var isBookmarked: Bool {
        bookmarkService.isBookmarked(product: product)
    }
    
    init(product: Product, bookmarkService: BookmarkServiceProtocol) {
        self.product = product
        self.bookmarkService = bookmarkService
    }
    
    /// Toggles the bookmark status for the product.
    func toggleBookmark() {
        bookmarkService.toggleBookmark(for: product)
    }
}
