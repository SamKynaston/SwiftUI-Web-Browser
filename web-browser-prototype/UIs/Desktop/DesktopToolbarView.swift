//
//  WebToolbar.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI
import WebKit

#if os(macOS)
struct DesktopToolBarView: ToolbarContent {
    @Bindable var tabManager: TabManager

    var activeTab: TabModel? {
        tabManager.activeTab
    }
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .navigation) {
            ControlButtons(tabManager: tabManager)
        }
        
        ToolbarItem(placement: .principal) {
            AddressBar(tabManager: tabManager)
                .frame(width: 350)
        }
        
        ToolbarItem(placement: .primaryAction) {
            Button {
                tabManager.createTab()
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}
#endif
