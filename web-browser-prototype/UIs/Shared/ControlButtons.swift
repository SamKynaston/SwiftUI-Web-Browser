//
//  ControlButtons.swift
//  web-browser-prototype
//
//  Created by Sam on 09/09/2026.
//

import SwiftUI

struct ControlButtons: View {
    @Bindable var tabManager: TabManager

    private var forwardButtonView: some View {
        Button {
            tabManager.goForward()
        } label: {
            Image(systemName: "chevron.forward")
        }
        .disabled(tabManager.activeTab?.canGoForward != true)
    }
    
    @ViewBuilder
    var forwardButton: some View {
        #if os(iOS)
        if let tab = tabManager.activeTab, tab.canGoForward {
            forwardButtonView
        }
        #else
        forwardButtonView
        #endif
    }
    
    var body: some View {
        ControlGroup {
            Button {
                tabManager.goBack()
            } label: {
                Image(systemName: "chevron.backward")
            }
            .disabled(tabManager.activeTab?.canGoBack != true)
            
            forwardButton
        }
        .controlGroupStyle(.navigation)
    }
}
