//
//  ErrorView.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 15/06/25.
//

import SwiftUI

struct ErrorView: View {
    
    /// The message to display to the user.
    let message: String
    
    /// Action to perform when the user taps Retry.
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Retry", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
#Preview {
    ErrorView(message: "Error Message") { }
}
