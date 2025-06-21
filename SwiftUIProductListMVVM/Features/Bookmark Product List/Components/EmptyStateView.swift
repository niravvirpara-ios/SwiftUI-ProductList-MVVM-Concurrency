//
//  EmptyStateView.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 15/06/25.
//

import SwiftUI

struct EmptyStateView: View {
    
    let icon: String    = "bookmark"
    let title: String   = "No Bookmarks Yet"
    let message: String = "Save products by tapping the bookmark icon"
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundStyle(.gray)
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.title2)
                
                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    EmptyStateView()
}
