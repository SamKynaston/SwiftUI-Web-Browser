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
        activeGroup = group
        activeTab = group.tabs.first
    }

    func selectTab(_ tab: TabModel, in group: TabGroupModel) {
        activeGroup = group
        activeTab = tab
    }
    
    func createTabGroup(name: String) {
        let group = TabGroupModel(
            name: name,
            tabs: []
        )

        tabGroups.append(group)

        activeGroup = group
        activeTab = nil
    }
    
    func createTab(urlString: String = "https://google.com", in group: TabGroupModel? = nil) {
        guard let url = URL(string: urlString) else {
            return
        }

        let newTab = TabModel(
            url: url
        )

        guard let targetGroup = group ?? activeGroup else {
            return
        }
        targetGroup.tabs.append(newTab)

        activeGroup = targetGroup
        activeTab = newTab
    }

    func destroyTab(_ tab: TabModel, in group: TabGroupModel) {
        tab.webView.navigationDelegate = nil
        tab.webView.stopLoading()

        group.tabs.removeAll { $0 === tab }

        if activeTab === tab {
            activeTab = group.tabs.first
        }
    }
    
    func destroyTabGroup(_ group: TabGroupModel?) {
        let targetGroup = group ?? activeGroup
        
        destroyAllTabsInGroup(targetGroup)
        
        tabGroups.removeAll { $0.id == targetGroup?.id }
    }

    func moveTab(from source: IndexSet, to destination: Int, in group: TabGroupModel) {
        group.tabs.move(
            fromOffsets: source,
            toOffset: destination
        )
    }

    func goBack() {
        activeTab?.webView.goBack()
    }

    func goForward() {
        activeTab?.webView.goForward()
    }

    func reload() {
        activeTab?.webView.reload()
    }
    
    func navigate(to text: String) {
        var text = text.trimmingCharacters(in: .whitespacesAndNewlines)

        let isWebsite = text.contains(/^(https?:\/\/)?(www\.)?[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+(\/.*)?$/)

        if isWebsite {
            if !text.contains("://") {
                text = "https://" + text
            }
        } else {
            let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? text
            text = "https://www.google.com/search?q=\(query)"
        }

        guard let url = URL(string: text) else { return }
        activeTab?.webView.load(URLRequest(url: url))
    }
    
    func setActiveTabTitle(_ title: String) {
        activeTab?.title = title
    }
    
    func setActiveTabUrl(_ url: URL) {
        activeTab?.url = url
    }
    
    func setTabTitle(_ title: String, for tab: TabModel) {
        tab.title = title
    }
    
    func setTabUrl(_ url: URL, for tab: TabModel) {
        tab.url = url
    }
    
    func destroyAllTabsInGroup(_ group: TabGroupModel?) {
        guard let targetGroup = group ?? activeGroup else {
            return
        }

        for tab in targetGroup.tabs {
            tab.webView.navigationDelegate = nil
            tab.webView.stopLoading()
        }
    }
}
