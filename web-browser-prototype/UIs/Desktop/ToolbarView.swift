//
//  WebToolbar.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI
import WebKit

struct ToolBarView: ToolbarContent {
    @Bindable var browserManager: BrowserTabManager

    var activeTab: TabModel? {
        browserManager.activeTab
    }
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .navigation) {
            ControlGroup {
                Button {
                    browserManager.goBack()
                } label: {
                    Image(systemName: "chevron.backward")
                }
                .disabled(!(activeTab?.browserWebManager.canGoBack ?? false))
          
                Button {
                    browserManager.goForward()
                } label: {
                    Image(systemName: "chevron.forward")
                }
                .disabled(!(activeTab?.browserWebManager.canGoForward ?? false))
            }
            .controlGroupStyle(.navigation)
        }
        
        ToolbarItem(placement: .principal) {
            AddressBar(browserManager: browserManager)
                .frame(width: 350)
        }
        
        ToolbarItem(placement: .primaryAction) {
            Button {
                browserManager.createTab()
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}
