//
//  ProductListContentView.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 15/06/25.
//

import SwiftUI

struct ProductListContentView: View {
    
    @ObservedObject var bookmarkService : BookmarkService
    
    let sections: [ProductListViewModel.ProductSection]
    let appDIContainer : AppDIContainer
    let onBookmarkToggle: (Product) -> Void
    let onRefresh: () -> Void
     
    var body: some View {
        
        List {
            ForEach(sections) { section in
                Section(header: Text(section.category.capitalized)) {
                    
                    ForEach(section.products) { product in
                        NavigationLink {
                            appDIContainer.makeProductDetailsDIContainer(product: product).makeView()
                        } label: {
                            ProductRowView(
                                product: product,
                                isBookmarked: bookmarkService.isBookmarked(product: product),
                                onBookmarkToggle: {
                                    onBookmarkToggle(product)
                                }
                            )
                        }
                    }
                    
                }
            }
        }
        .listStyle(.insetGrouped)
        .refreshable {
            await onRefresh()
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
    
    let sections = ProductListViewModel.ProductSection(category: "Beauty", products: [product])
     
    let productSections: [ProductListViewModel.ProductSection] = [sections]
    
    ProductListContentView(
        bookmarkService: BookmarkService(),
        sections: productSections,
        appDIContainer: AppDIContainer.shared,
        onBookmarkToggle: { _ in },
        onRefresh: { }
    )
}
