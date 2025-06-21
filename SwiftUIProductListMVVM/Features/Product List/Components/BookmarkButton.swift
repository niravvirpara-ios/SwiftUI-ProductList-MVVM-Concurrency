//
//  BookmarkButton.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 15/06/25.
//

import SwiftUI

struct BookmarkButton: View {
    
    let isBookmarked: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                .font(.title2)
                .foregroundStyle(isBookmarked ? .blue : .gray)
                .contentTransition(.symbolEffect(.replace))
        }
        .buttonStyle(.plain)
    }
}
