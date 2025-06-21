//
//  ProductModel.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

struct Product: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let thumbnail: String
    let availabilityStatus: String
    let price: Double
    let stock: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, title, description, category, thumbnail, availabilityStatus, price, stock
    }
}
