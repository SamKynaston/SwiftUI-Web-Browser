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
                    VStack(spacing: 0) {
                        Button {
                            tabManager.selectGroup(group)
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "square.on.square")
                                    .foregroundStyle(.tint)
                                
                                Text(group.name)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                                Button {
                                    tabManager.createTab(urlString: "https://google.com", in: group.id)
                                } label: {
                                    Image(systemName: "plus.square")
                                        .foregroundStyle(.tint)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .buttonStyle(.plain)
                        
                        if tabManager.activeGroupId == group.id {
                            Spacer()
                            ForEach(group.tabs) { tab in
                                Button {
                                    tabManager.selectTab(tab, in: group)
                                } label: {
                                    HStack(spacing: 8) {
                                        Image(systemName: "globe")
                                            .foregroundStyle(.tint)
                                        
                                        Text(tab.title)
                                            .lineLimit(1)
                                        
                                        Spacer()
                                        
                                        Button {
                                            tabManager.destroyTab(tab: tab.id, in: group.id)
                                        } label: {
                                            Image(systemName: "xmark.circle")
                                                .foregroundStyle(.red)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 8)
                                    .background {
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(
                                                tabManager.activeTabId == tab.id
                                                ? Color.accentColor.opacity(0.15)
                                                : .clear
                                            )
                                    }
                                    .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                            }
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
