//
//  MainDesktopView.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI

struct MainDesktopView: View {
    @Bindable var browserManager: BrowserTabManager

    var body: some View {
        NavigationSplitView {
            SideBarView(browserManager: browserManager)
        } detail: {
            Page(browserManager: browserManager)
            
            .toolbar {
                ToolBarView(
                    browserManager: browserManager
                )
            }
        }
        //.navigationSplitViewStyle(.balanced)
    }
}
