//
//  ProductDetailsView.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 15/06/25.
//

import SwiftUI

struct ProductDetailsView: View {
    
    @StateObject private var viewModel: ProductDetailsViewModel
    
    init(viewModel: ProductDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                productImage
                mainDetailsContent
            }
            .padding()
        }
        .navigationTitle("Product Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var productImage: some View {
        AsyncImage(url: URL(string: viewModel.product.thumbnail)) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
            case .failure:
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
            default:
                ProgressView()
            }
        }
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity, maxHeight: 250)
        .cornerRadius(12)
    }
    
    private var mainDetailsContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack {
                Text(viewModel.product.title)
                    .font(.title.bold())
                Spacer()
                BookmarkButton(
                    isBookmarked: viewModel.isBookmarked,
                    action: { viewModel.toggleBookmark() }
                )
            }
            
            Text(viewModel.product.price, format: .currency(code: "USD"))
                .font(.title2)
                .foregroundColor(.green)
            
            Text(viewModel.product.description)
                .font(.body)
            
            HStack {
                Text("Category: \(viewModel.product.category.capitalized)")
                Spacer()
                Text("Stock: \(viewModel.product.stock)")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            Text("Availability: \(viewModel.product.availabilityStatus)")
                .font(.subheadline)
                .foregroundColor(viewModel.product.availabilityStatus == "In Stock" ? .green : .red)
        }
    }
}

#Preview {
    let product = Product(
        id: 1,
        title: "iPhone 9",
        description: "An Apple mobile phone with great features and performance.",
        category: "smartphones",
        thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
        availabilityStatus: "In Stock",
        price: 594,
        stock: 99
    )
    
    ProductDetailsView(viewModel: ProductDetailsViewModel(product: product, bookmarkService: BookmarkService()))
}
