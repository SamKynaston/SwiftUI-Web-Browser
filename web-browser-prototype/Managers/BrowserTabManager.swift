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
    var tabGroups: [TabGroupModel] = [
        TabGroupModel(name: "Default", tabs: [
            TabModel(title: "Google", url: URL(string: "https://www.google.com")!),
            TabModel(title: "Amazon", url: URL(string: "https://www.amazon.com")!)
        ]),
        
        TabGroupModel(name: "Default2", tabs: [
            TabModel(title: "Google", url: URL(string: "https://www.google.com")!),
            TabModel(title: "Amazon", url: URL(string: "https://www.amazon.com")!)
        ])
    ]
    
    var tabSwitchDirection: Int = 0
    var activeTabId: UUID?
    var activeGroupId: UUID?

    init() {
        activeGroupId = tabGroups.first?.id
        activeTabId = tabGroups.first?.tabs.first?.id
    }

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
    
    func createTab(
        title: String,
        urlString: String,
        in groupID: UUID? = nil
    ) {
        guard let url = URL(string: urlString) else {
            return
        }

        let newTab = TabModel(
            title: title,
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

    func destroyTab(
        at offsets: IndexSet,
        in groupID: UUID
    ) {
        guard let groupIndex = tabGroups.firstIndex(where: {
            $0.id == groupID
        }) else {
            return
        }

        let removedTabs = offsets.map {
            tabGroups[groupIndex].tabs[$0]
        }

        tabGroups[groupIndex].tabs.remove(atOffsets: offsets)

        if let activeTabId,
           removedTabs.contains(where: {
               $0.id == activeTabId
           }) {

            self.activeTabId =
                tabGroups[groupIndex].tabs.first?.id
        }
    }

    func moveTab(
        from source: IndexSet,
        to destination: Int,
        in groupID: UUID
    ) {
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
    
    func switchToNextTab() {
        guard let activeTabId,
              let index = browserTabs.firstIndex(where: {
                  $0.id == activeTabId
              }),
              !browserTabs.isEmpty else {
            return
        }

        let nextIndex = (index + 1) % browserTabs.count

        tabSwitchDirection = 1
        self.activeTabId = browserTabs[nextIndex].id
    }

    func switchToPreviousTab() {
        guard let activeTabId,
              let index = browserTabs.firstIndex(where: {
                  $0.id == activeTabId
              }) else {
            return
        }

        let previousIndex =
            (index - 1 + browserTabs.count) % browserTabs.count

        tabSwitchDirection = -1
        self.activeTabId = browserTabs[previousIndex].id
    }
}
