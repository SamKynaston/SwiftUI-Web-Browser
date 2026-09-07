//
//  SideBar.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI

struct SideBarView: View {
    @Bindable var browserManager: BrowserTabManager

    var body: some View {
        List(selection: $browserManager.activeTabId) {
            ForEach(browserManager.tabs) { tab in
                Text(tab.title)
                    .tag(tab.id as UUID?)
            }
        }
    }
}
