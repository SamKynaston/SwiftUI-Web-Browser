//
//  Page.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI

struct TabRenderer: View {
    @Bindable var browserManager: BrowserTabManager

    var body: some View {
        GeometryReader { geometry in
            if let tab = browserManager.activeTab {
                WebRenderer(
                    url: tab.url,
                    manager: tab.browserWebManager
                )
                .id(tab.id)
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
            }
        }
        .clipped()
    }
    
    private func tabWebView(
        tab: TabModel,
        width: CGFloat,
        height: CGFloat
    ) -> some View {
        WebRenderer(
            url: tab.url,
            manager: tab.browserWebManager
        )
        .id(tab.id)
        .frame(width: width, height: height)
    }

    // For reuse at a later date.
    /*private func tabOffset(
        tab: TabModel,
        width: CGFloat
    ) -> CGFloat {
        if tab.id == browserManager.activeTabId {
            return 0
        }

        if tab.id == browserManager.adjacentTabId {
            return browserManager.tabSwitchDirection > 0
                ? width
                : -width
        }

        return width * 2
    }*/
}
