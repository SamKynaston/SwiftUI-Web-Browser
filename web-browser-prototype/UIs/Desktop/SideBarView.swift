//
//  SideBar.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI

struct SideBarView: View {
    @Bindable var tabManager: TabManager

    var body: some View {
        List {
            Section {
                ForEach(tabManager.tabGroups) { group in
                    SideBarTabGroup(tabManager: tabManager, group: group)
                    
                    if tabManager.activeGroupId == group.id {           
                        ForEach(group.tabs) { tab in
                            SideBarTab(tabManager: tabManager, group: group, tab: tab)
                        }
                    }
                }
            } header: {
                HStack {
                    Text("Tab Groups")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 6)
                }
            }
        }
        .listStyle(.sidebar)
    }
}
