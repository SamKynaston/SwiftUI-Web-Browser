//
//  Page.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI

struct TabRenderer: View {
    @Bindable var tabManager: TabManager

    var body: some View {
        ZStack {
            ForEach(tabManager.activeGroup?.tabs ?? []) { tab in
                WebRenderer(
                    manager: tabManager,
                    tab: tab
                )
                .id(tab.id)
                .opacity(tab.id == tabManager.activeTab?.id ? 1 : 0)
                .zIndex(tab.id == tabManager.activeTab?.id ? 1 : 0)
            }
        }
    }
}
