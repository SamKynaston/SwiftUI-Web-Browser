//
//  WebToolbar.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI
import WebKit

struct DesktopToolBarView: ToolbarContent {
    @Bindable var tabManager: TabManager

    var activeTab: TabModel? {
        tabManager.activeTab
    }
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .navigation) {
            ControlGroup {
                Button {
                    tabManager.goBack()
                } label: {
                    Image(systemName: "chevron.backward")
                }
                .disabled(!tabManager.canGoBack)

                Button {
                    tabManager.goForward()
                } label: {
                    Image(systemName: "chevron.forward")
                }
                .disabled(!tabManager.canGoForward)
            }
            .controlGroupStyle(.navigation)
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
