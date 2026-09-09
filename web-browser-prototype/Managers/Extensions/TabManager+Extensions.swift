//
//  BrowserTabManager+Extensions.swift
//  web-browser-prototype
//
//  Created by Sam on 09/09/2026.
//

import SwiftUI
import WebKit

extension TabManager {
    func selectGroup(_ group: TabGroupModel) {
        activeGroupId = group.id
        activeTabId = group.tabs.first?.id
    }

    func selectGroup(id: UUID) {
        guard let group = tabGroups.first(where: {
            $0.id == id
        }) else {
            return
        }

        selectGroup(group)
    }

    func selectTab(_ tab: TabModel, in group: TabGroupModel) {
        activeGroupId = group.id
        activeTabId = tab.id
    }
    
    func createTabGroup(name: String) {
        let group = TabGroupModel(
            name: name,
            tabs: []
        )

        tabGroups.append(group)

        activeGroupId = group.id
        activeTabId = nil
    }

    func getTabGroup(id: UUID) -> TabGroupModel? {
        tabGroups.first {
            $0.id == id
        }
    }
    
    func createTab(urlString: String = "https://google.com", in groupID: UUID? = nil) {
        guard let url = URL(string: urlString) else {
            return
        }

        let newTab = TabModel(
            url: url
        )

        let targetGroupID = groupID ?? activeGroupId

        guard let targetGroupID,
              let groupIndex = tabGroups.firstIndex(where: {
                  $0.id == targetGroupID
              }) else {
            return
        }

        tabGroups[groupIndex].tabs.append(newTab)

        activeGroupId = targetGroupID
        activeTabId = newTab.id
    }

    func destroyTab(tab tabId: UUID, in groupID: UUID) {
        guard let groupIndex = tabGroups.firstIndex(where: { $0.id == groupID }) else {
            return
        }

        tabGroups[groupIndex].tabs.removeAll { $0.id == tabId }
    }
    
    func destroyTabGroup(_ groupID: UUID?) {
        tabGroups.removeAll(where: { $0.id == groupID ?? activeGroupId })
    }

    func moveTab(from source: IndexSet, to destination: Int, in groupID: UUID) {
        guard let groupIndex = tabGroups.firstIndex(where: {
            $0.id == groupID
        }) else {
            return
        }

        tabGroups[groupIndex].tabs.move(
            fromOffsets: source,
            toOffset: destination
        )
    }

    func getTab(id: UUID) -> TabModel? {
        browserTabs.first {
            $0.id == id
        }
    }

    func goBack() {
        activeTab?.webView?.goBack()
    }

    func goForward() {
        activeTab?.webView?.goForward()
    }

    func reload() {
        activeTab?.webView?.reload()
    }
    
    func navigate(to text: String) {
        var text = text.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let websiteRegex = try! Regex(#"^(https?://)?(www\.)?[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+(/.*)?$"#)
        
        if text.contains(websiteRegex) {
            if !text.contains("://") {
                text = "https://" + text
            }
        } else {
            let query = text.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) ?? text

            text = "https://www.google.com/search?q=\(query)"
        }
        
        guard let url = URL(string: text) else {
            return
        }
        
        activeTab?.webView?.load(URLRequest(url: url))
    }
    
    func setActiveTabTitle(_ title: String) {
        guard let activeTabId else { return }

        for groupIndex in tabGroups.indices {
            if let tabIndex = tabGroups[groupIndex].tabs.firstIndex(where: { $0.id == activeTabId }) {
                tabGroups[groupIndex].tabs[tabIndex].title = title
                return
            }
        }
    }
    
    func setActiveTabUrl(_ url: URL) {
        guard let activeTabId else { return }

        for groupIndex in tabGroups.indices {
            if let tabIndex = tabGroups[groupIndex].tabs.firstIndex(where: { $0.id == activeTabId }) {
                tabGroups[groupIndex].tabs[tabIndex].url = url
                return
            }
        }
    }
    
    func setActiveTabWebview(_ webview: WKWebView) {
        guard let activeTabId else { return }

        for groupIndex in tabGroups.indices {
            if let tabIndex = tabGroups[groupIndex].tabs.firstIndex(where: { $0.id == activeTabId }) {
                tabGroups[groupIndex].tabs[tabIndex].webView = webview
                return
            }
        }
    }
    
    func setTabTitle(_ title: String, for tabId: UUID) {
        for groupIndex in tabGroups.indices {
            if let tabIndex = tabGroups[groupIndex].tabs.firstIndex(where: { $0.id == tabId }) {
                tabGroups[groupIndex].tabs[tabIndex].title = title
                return
            }
        }
    }
    
    func setTabUrl(_ url: URL, for tabId: UUID) {
        for groupIndex in tabGroups.indices {
            if let tabIndex = tabGroups[groupIndex].tabs.firstIndex(where: { $0.id == tabId }) {
                tabGroups[groupIndex].tabs[tabIndex].url = url
                return
            }
        }
    }
    
    func setTabWebview(_ webview: WKWebView, for tabId: UUID) {
        for groupIndex in tabGroups.indices {
            if let tabIndex = tabGroups[groupIndex].tabs.firstIndex(where: { $0.id == tabId }) {
                tabGroups[groupIndex].tabs[tabIndex].webView = webview
                return
            }
        }
    }
}
