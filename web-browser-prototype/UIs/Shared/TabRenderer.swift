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
            ForEach(browserManager.tabs) { tab in
                tabWebView(
                    tab: tab,
                    width: geometry.size.width,
                    height: geometry.size.height
                )
            }
        }
        .clipped()
    }
    
    private func tabWebView(
        tab: BrowserTab,
        width: CGFloat,
        height: CGFloat
    ) -> some View {
        WebRenderer(
            url: tab.url,
            manager: tab.browserWebManager
        )
        .id(tab.id)
        .frame(width: width, height: height)
        .offset(
            x: tabOffset(
                tab: tab,
                width: width
            )
        )
    }

    private func tabOffset(
        tab: BrowserTab,
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
    }
}
