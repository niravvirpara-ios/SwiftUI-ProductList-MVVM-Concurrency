//
//  ProductListDIContainer.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

import SwiftUI

@MainActor
final class ProductListDIContainer {
    
    private let bookmarkService: BookmarkServiceProtocol
    private let productRespository: ProductRepositoryProtocol
    
    init(bookmarkService: BookmarkServiceProtocol, productReportository: ProductRepositoryProtocol) {
        self.bookmarkService = bookmarkService
        self.productRespository = productReportository
    }
     
    /// Create the ViewModel for the ProductListView.
    func makeViewModel() -> ProductListViewModel {
        ProductListViewModel(bookmarkService: bookmarkService, repository: productRespository)
    }
    
    /// Create the ProductListView with injected ViewModel.
    func makeView() -> some View {
        ProductListView(viewModel: makeViewModel())
    }
}
