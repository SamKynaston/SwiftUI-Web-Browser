//
//  Tabs.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import Foundation
import SwiftUI

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
    
    func visitUrl(_ url: URL, in tabId: UUID) {
        guard let index = tabs.firstIndex(of: getTab(UUID: tabId)!) else { return }
        
        tabs[index].visit(url)
    }
    
    func goBack() {
        guard let activeTabId else { return }
        guard let index = tabs.firstIndex(where: { $0.id == activeTabId }) else { return }

        tabs[index].goBack()
    }

    func goForward() {
        guard let activeTabId else { return }
        guard let index = tabs.firstIndex(where: { $0.id == activeTabId }) else { return }

        tabs[index].goForward()
    }
}
