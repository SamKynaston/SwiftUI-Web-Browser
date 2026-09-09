//
//  TabManager.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import Foundation
import SwiftUI
import WebKit

@Observable
class TabManager {
    var tabGroups: [TabGroupModel] = [
        TabGroupModel(name: "Default", tabs: [
            TabModel(url: URL(string: "https://www.google.com")!),
            TabModel(url: URL(string: "https://www.amazon.com")!)
        ]),
        
        TabGroupModel(name: "Default2", tabs: [
            TabModel(url: URL(string: "https://www.google.com")!),
            TabModel(url: URL(string: "https://www.amazon.com")!)
        ])
    ]
    
    var tabSwitchDirection: Int = 0
    var activeTabId: UUID?
    var activeGroupId: UUID?
    var onNavigationChange: ((URL?, String) -> Void)?

    var canGoBack = false
    var canGoForward = false
    var isLoading = false
    var loadingProgress: Double = 0.0
    
    var browserTabs: [TabModel] {
        tabGroups.flatMap(\.tabs)
    }

    var activeTab: TabModel? {
        guard let activeTabId else {
            return nil
        }

        return browserTabs.first {
            $0.id == activeTabId
        }
    }

    var activeGroup: TabGroupModel? {
        guard let activeGroupId else {
            return nil
        }

        return tabGroups.first {
            $0.id == activeGroupId
        }
    }

    init() {
        activeGroupId = tabGroups.first?.id
        activeTabId = tabGroups.first?.tabs.first?.id
    }
}
