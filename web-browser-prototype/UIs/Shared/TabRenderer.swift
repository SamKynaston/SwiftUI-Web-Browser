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
        GeometryReader { geometry in
            if let tab = tabManager.activeTab {
                WebRenderer(
                    url: tab.url,
                    manager: tabManager
                )
                .id(tab.id)
            }
        }
        .clipped()
    }
}
