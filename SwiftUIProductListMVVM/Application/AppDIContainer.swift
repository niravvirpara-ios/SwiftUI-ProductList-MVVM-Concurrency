//
//  AppDIContainer.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

import Foundation

@MainActor
final class AppDIContainer: ObservableObject {
    
    static let shared = AppDIContainer()
    
    private init() {}
    
    lazy var apiService: APIServiceProtocol = APIService()
    private(set) lazy var bookmarkService: BookmarkService = BookmarkService()
    private(set) lazy var productRepository: ProductRepository = ProductRepository(apiService: apiService)
     
    /// Creates DI container specific to the Product List feature.
    func makeProductListDIContainer() -> ProductListDIContainer {
        ProductListDIContainer(bookmarkService: bookmarkService, productReportository: productRepository)
    }
    
    /// Creates DI container specific to the Bookmark List feature.
    func makeBookmarkListDIContainer() -> BookmarkListDIContainer {
        BookmarkListDIContainer(bookmarkService: bookmarkService, productRepository: productRepository)
    }
    
    /// Creates DI container specific to the Product Details feature.
    func makeProductDetailsDIContainer(product: Product) -> ProductDetailsDIContainer {
        ProductDetailsDIContainer(
            product: product,
            bookmarkService: bookmarkService
        )
    }
}
