//
//  BrowserTabManager.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import Foundation
import SwiftUI
import WebKit

@Observable
class BrowserTabManager {
    var tabs: [TabModel] =  [
        TabModel(title: "Google", url: URL(string: "https://www.google.com")!),
        TabModel(title: "Amazon", url: URL(string: "https://www.amazon.com")!)
    ]
    
    var tabSwitchDirection: Int = 0
    var activeTabId: UUID?
    
    init() {
        activeTabId = tabs.first?.id
    }
    
    var adjacentTabId: UUID? {
        guard let activeTabId,
              let index = tabs.firstIndex(where: {
                  $0.id == activeTabId
              }),
              tabs.count > 1
        else {
            return nil
        }

        if tabSwitchDirection > 0 {
            let nextIndex = (index + 1) % tabs.count
            return tabs[nextIndex].id
        } else {
            let previousIndex = (index - 1 + tabs.count) % tabs.count
            return tabs[previousIndex].id
        }
    }
    
    var activeTab: TabModel? {
        guard let activeTabId else { return nil }

        return tabs.first {
            $0.id == activeTabId
        }
    }
    
    func createTab(title: String, urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let newTab = TabModel(title: title, url: url)
        tabs.append(newTab)
        activeTabId = newTab.id
    }
    
    func destroyTab(at offsets: IndexSet) {
        tabs.remove(atOffsets: offsets)
    }
    
    func getTab(UUID: UUID) -> TabModel? {
        tabs.first { $0.id == UUID }
    }
    
    func switchToNextTab() {
        guard let activeTabId,
              let index = tabs.firstIndex(where: { $0.id == activeTabId }),
              !tabs.isEmpty
        else { return }
        
        let nextIndex = (index + 1) % tabs.count
        
        tabSwitchDirection = 1
        self.activeTabId = tabs[nextIndex].id
    }
    
    func switchToPreviousTab() {
        guard let activeTabId,
              let index = tabs.firstIndex(where: { $0.id == activeTabId })
        else { return }
        
        let prevIndex = (index - 1 + tabs.count) % tabs.count
        
        tabSwitchDirection = -1
        self.activeTabId = tabs[prevIndex].id
    }
    
    func navigate(to url: String) {
        activeTab?.browserWebManager.navigate(to: url)
    }
    
    func goBack() {
        activeTab?.browserWebManager.goBack()
    }

    func goForward() {
        activeTab?.browserWebManager.goForward()
    }

    func reload() {
        activeTab?.browserWebManager.reload()
    }
}
