//
//  ProductDetailsDIContainer.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 15/06/25.
//

import SwiftUI

final class ProductDetailsDIContainer {
    
    private let product: Product
    private let bookmarkService: BookmarkServiceProtocol
    
    init(product: Product, bookmarkService: BookmarkServiceProtocol) {
        self.product = product
        self.bookmarkService = bookmarkService
    }
    
    /// Create the ViewModel for the ProductDetailsView.
    @MainActor
    func makeViewModel() -> ProductDetailsViewModel {
        ProductDetailsViewModel(
            product: product,
            bookmarkService: bookmarkService
        )
    }
    
    /// Create the ProductDetailsView with injected ViewModel.
    @MainActor
    func makeView() -> some View {
        ProductDetailsView(viewModel: makeViewModel())
    }
}
