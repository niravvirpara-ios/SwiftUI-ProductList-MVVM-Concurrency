//
//  ProductRowView.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 15/06/25.
//

import SwiftUI

struct ProductRowView: View {
    
    let product: Product
    let isBookmarked: Bool
    let onBookmarkToggle: () -> Void
    
    var body: some View {
        HStack(spacing : 12) {
            productImage
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .cornerRadius(8)
            
            productDetails
        }
        .padding(.horizontal, 8)
    }
    
    private var productImage: some View {
        AsyncImage(url: URL(string: product.thumbnail)) { phase in
            switch phase {
            case .success(let image):
                image.resizable()
            case .failure:
                Image(systemName: "exclamationmark.triangle")
            default:
                ProgressView()
            }
        }
    }
    
    private var productDetails: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                Text(product.title)
                    .font(.headline)
                
                Spacer()
                
                BookmarkButton(
                    isBookmarked: isBookmarked,
                    action: onBookmarkToggle
                )
            }
            
            Text(product.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
            
            HStack {
                Text("\(product.availabilityStatus) : \(product.stock)")
                    .font(.caption)
                
                Spacer()
                
                Text(product.price, format: .currency(code: "USD"))
                    .font(.body.bold())
            }
        }
    }
    
}

#Preview {
    let product = Product(
        id: 1,
        title: "Essence Mascara Lash Princess",
        description: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.",
        category: "beauty",
        thumbnail: "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/1.webp",
        availabilityStatus: "In Stock",
        price: 9.99,
        stock: 99
    )
     
    ProductRowView(product: product, isBookmarked: true, onBookmarkToggle: { })
}
