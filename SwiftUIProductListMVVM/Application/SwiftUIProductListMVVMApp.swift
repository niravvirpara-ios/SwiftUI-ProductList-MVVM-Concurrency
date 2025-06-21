//
//  SwiftUIProductListMVVMApp.swift
//  SwiftUIProductListMVVM
//
//  Created by Nirav Virpara on 13/06/25.
//

import SwiftUI

@main
struct SwiftUIProductListMVVMApp: App {
    
    let appDIContainer = AppDIContainer.shared
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(appDIContainer.bookmarkService)
                .environmentObject(appDIContainer)
        }
    }
}
