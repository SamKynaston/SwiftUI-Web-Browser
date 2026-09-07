//
//  Tabs.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import Foundation
import SwiftUI
import WebKit

@Observable
class BrowserManager {
    var tabs: [BrowserTab] =  [
        BrowserTab(title: "Google", url: URL(string: "https://www.google.com")!),
        BrowserTab(title: "Amazon", url: URL(string: "https://www.amazon.com")!)
    ]
    
    var activeTabId: UUID?
    
    init() {
        activeTabId = tabs.first?.id
    }
    
    var activeTab: BrowserTab? {
        guard let activeTabId else { return nil }

        return tabs.first {
            $0.id == activeTabId
        }
    }
    
    func createTab(title: String, urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let newTab = BrowserTab(title: title, url: url)
        tabs.append(newTab)
        activeTabId = newTab.id
    }
    
    func destroyTab(at offsets: IndexSet) {
        tabs.remove(atOffsets: offsets)
    }
    
    func getTab(UUID: UUID) -> BrowserTab? {
        tabs.first { $0.id == UUID }
    }
    
    func goBack() {
        activeTab?.browserWebManager.webView?.goBack()
    }

    func goForward() {
        activeTab?.browserWebManager.webView?.goForward()
    }

    func reload() {
        activeTab?.browserWebManager.webView?.reload()
    }
}
