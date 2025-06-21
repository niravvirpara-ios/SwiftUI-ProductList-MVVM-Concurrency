//
//  BookmarkListView.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

import SwiftUI

struct BookmarkListView: View {
    
    @StateObject private var viewModel: BookmarkListViewModel
    @EnvironmentObject private var appDIContainer: AppDIContainer
    
    init(viewModel: BookmarkListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            mainContentView
                .navigationTitle("Bookmarks")
        }
        .task {
            viewModel.loadBookmarkedProducts()
        }
    }
    
    @ViewBuilder
    private var mainContentView: some View {
        
        switch viewModel.state {
            
        case .idle, .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case .empty:
            EmptyStateView()
            
        case .loaded(let products):
            
            List(products) { product in
                NavigationLink {
                    appDIContainer.makeProductDetailsDIContainer(product: product).makeView()
                } label: {
                    ProductRowView(
                        product: product,
                        isBookmarked: true,
                        onBookmarkToggle: {
                            viewModel.toggleBookmark(for: product)
                        }
                    )
                }
            }
            .listStyle(.insetGrouped)
            
        case .error(let message):
            ErrorView(message: message, retryAction: {
                viewModel.loadBookmarkedProducts()
            })
        }
        
    }
}

#Preview {
    BookmarkListView(viewModel: BookmarkListViewModel(bookmarkService: BookmarkService(), productRepository: ProductRepository(apiService: MockAPIService())))
}
