//
//  WebToolbar.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI
import WebKit

struct ToolBarView: ToolbarContent {
    @Bindable var browserManager: BrowserManager
    @State private var addressBarText = ""

    init(browserManager: BrowserManager) {
        self.browserManager = browserManager

        let url = browserManager.activeTab?.browserWebManager.url
            ?? browserManager.activeTab?.url

        _addressBarText = State(
            initialValue: url?.absoluteString ?? ""
        )
    }
    
    var activeTab: BrowserTab? {
        browserManager.activeTab
    }
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .primaryAction) {
            Button {
                browserManager.goBack()
            } label: {
                Image(systemName: "arrowshape.turn.up.backward")
            }
            .disabled(!(activeTab?.browserWebManager.canGoBack ?? false))

            Button {
                browserManager.goForward()
            } label: {
                Image(systemName: "arrowshape.turn.up.forward")
            }
            .disabled(!(activeTab?.browserWebManager.canGoForward ?? false))
        }
        
        ToolbarItem(placement: .principal) {
            TextField("Address Bar", text: $addressBarText)
                .onSubmit {
                    navigate()
                }
                .frame(width: 320)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
        }
    }
    
    private func navigate() {
        var text = addressBarText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if !text.contains("://") {
            text = "https://" + text
        }

        guard let url = URL(string: text) else {
            return
        }

        activeTab?.browserWebManager.navigate(to: url)
    }

    private func updateAddressBar() {
        addressBarText =
            activeTab?.browserWebManager.url?.absoluteString
            ?? activeTab?.url.absoluteString
            ?? ""
    }
}
