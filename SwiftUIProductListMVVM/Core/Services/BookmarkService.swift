//
//  BookmarkService.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

import Foundation
import Combine

protocol BookmarkServiceProtocol: AnyObject {
    var bookmarks: Set<Int> { get }
    func isBookmarked(product: Product) -> Bool
    func toggleBookmark(for product: Product)
    var bookmarksPublisher: AnyPublisher<Set<Int>, Never> { get }
}

final class BookmarkService: BookmarkServiceProtocol, ObservableObject {
    
    @Published private(set) var bookmarks: Set<Int> = []
     
    var bookmarksPublisher: AnyPublisher<Set<Int>, Never> {
        $bookmarks.eraseToAnyPublisher()
    }
    
    /// Returns whether product is bookmarked.
    func isBookmarked(product: Product) -> Bool {
        bookmarks.contains(product.id)
    }
     
    /// Toggles the bookmark status for product.
    func toggleBookmark(for product: Product) {
        if bookmarks.contains(product.id) {
            bookmarks.remove(product.id)
        } else {
            bookmarks.insert(product.id)
        }
    }
}
