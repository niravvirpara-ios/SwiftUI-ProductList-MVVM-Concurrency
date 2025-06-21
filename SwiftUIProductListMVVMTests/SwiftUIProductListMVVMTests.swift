//
//  SwiftUIProductListMVVMTests.swift
//  SwiftUIProductListMVVMTests
//
//  Created by Nirav Virpara on 13/06/25.
//

import XCTest
import Combine
@testable import SwiftUIProductListMVVM

final class SwiftUIProductListMVVMTests: XCTestCase {

    private var viewModel: ProductListViewModel!
    private var mockService: MockAPIService!
    private var bookmarkService: BookmarkService!
    private var cancellables: Set<AnyCancellable> = []
 
    @MainActor
    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
        bookmarkService = BookmarkService()
        viewModel = ProductListViewModel(
            bookmarkService: bookmarkService,
            repository: ProductRepository(apiService: mockService)
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        bookmarkService = nil
        cancellables.removeAll()
        super.tearDown()
    }

    @MainActor
    func testSuccessfulLoad_shouldReturnOneProduct() {
        // Arrange
        mockService.shouldSucceed = true
        let expectation = XCTestExpectation(description: "Products loaded successfully")

        // Act
        viewModel.$state
            .dropFirst()
            .sink { state in
                if case .loaded(let sections) = state {
                    XCTAssertEqual(sections.count, 1)
                    XCTAssertEqual(sections.first?.category, "beauty")
                    XCTAssertEqual(sections.first?.products.count, 1)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        Task {
            await viewModel.loadProducts()
        }
        
        // Assert
        wait(for: [expectation], timeout: 2.0)
    }

    @MainActor
    func testFetchProductsFailure_shouldReturnErrorState() {
        
        // Arrange
        mockService.shouldSucceed = false
        let expectation = XCTestExpectation(description: "Products fetch fails and shows error")

        // Act
        viewModel.$state
            .dropFirst()
            .sink { state in
                if case .error(let message) = state {
                    XCTAssertFalse(message.isEmpty)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        Task {
            await viewModel.loadProducts()
        }
        
        // Assert
        wait(for: [expectation], timeout: 2.0)
    }

    @MainActor
    func testToggleBookmark_shouldUpdateBookmarkState() {
        
        // Arrange
        let product = mockService.mockProducts.first!
        XCTAssertFalse(bookmarkService.isBookmarked(product: product))
        
        // Act
        viewModel.toggleBookmark(for: product)
        
        // Assert
        XCTAssertTrue(bookmarkService.isBookmarked(product: product))
        
        // Toggle again
        viewModel.toggleBookmark(for: product)
        XCTAssertFalse(bookmarkService.isBookmarked(product: product))
    }
}
