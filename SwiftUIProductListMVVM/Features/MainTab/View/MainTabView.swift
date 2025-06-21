//
//  MainTabView.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 14/06/25.
//

import SwiftUI

public struct MainTabView: View {
    
    @EnvironmentObject private var appDIContainer: AppDIContainer
    
    public var body: some View {
        TabView {
            
            /// Products Tab
            appDIContainer.makeProductListDIContainer().makeView()
                .tabItem {
                    Label("Products", systemImage: "list.bullet")
                }
            
            /// Bookmarks Tab
            appDIContainer.makeBookmarkListDIContainer().makeView()
                .tabItem {
                    Label("Bookmarks", systemImage: "bookmark")
                }
        }
        
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppDIContainer.shared)
}
