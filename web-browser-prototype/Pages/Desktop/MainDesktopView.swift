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
            //.toolbar(removing: .sidebarToggle)
        } detail: {
            if let selectedId = browserManager.activeTabId {
                if let activeTab = browserManager.getTab(UUID: selectedId) {
                    /*CustomWebView(
                        url: activeTab.url,
                        manager: activeTab.browserWebManager
                    )
                    .id(activeTab.id)

                    .toolbar {
                        ToolBarView(
                            browserManager: browserManager
                        )
                    }*/
                }
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}
