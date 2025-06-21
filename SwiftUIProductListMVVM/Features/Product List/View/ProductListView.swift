//
//  ProductListView.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

import SwiftUI

struct ProductListView: View {
    
    @StateObject private var viewModel: ProductListViewModel
    @EnvironmentObject private var bookmarkService: BookmarkService
    @EnvironmentObject private var appDIContainer: AppDIContainer
     
    init(viewModel: ProductListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            mainContent
                .navigationTitle("Products")
        }
        .task {
            await viewModel.loadProducts()
        }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        switch viewModel.state {
            
        case .idle, .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .error(let message):
            ErrorView(message: message) {
                Task {
                    await viewModel.loadProducts()
                }
            }
            
        case .loaded(let sections) :
            ProductListContentView(
                bookmarkService: bookmarkService,
                sections: sections,
                appDIContainer: appDIContainer,
                onBookmarkToggle: { product in
                    viewModel.toggleBookmark(for: product)
                },
                onRefresh: {
                    Task {
                        await viewModel.loadProducts()
                    }
                })
        }
    }
    
}

#Preview {
    let bookmarkService = BookmarkService()
    let appDIContainer = AppDIContainer.shared
    
    let mockViewModel = ProductListViewModel(
        bookmarkService: bookmarkService,
        repository: ProductRepository(apiService: MockAPIService())
    )
    
    return ProductListView(viewModel: mockViewModel)
        .environmentObject(bookmarkService)
        .environmentObject(appDIContainer)
}
