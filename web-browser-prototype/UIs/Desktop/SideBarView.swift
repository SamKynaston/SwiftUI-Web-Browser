//
//  SideBar.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI

struct SideBarView: View {
    @Bindable var browserManager: BrowserTabManager

    var body: some View {
        List {
            Section {
                ForEach(browserManager.tabGroups) { group in
                    VStack(spacing: 12) {
                        Button {
                            browserManager.selectGroup(group)
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "square.on.square")
                                    .foregroundStyle(.tint)

                                Text(group.name)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                                Button {
                                    browserManager.createTab(title: "Default", urlString: "https://google.com", in: group.id)
                                } label: {
                                    Image(systemName: "plus.square")
                                        .foregroundStyle(.tint)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .buttonStyle(.plain)
                        
                        if browserManager.activeGroupId == group.id {
                            ForEach(group.tabs) { tab in
                                Button {
                                    browserManager.selectTab(tab, in: group)
                                } label: {
                                    HStack(spacing: 8) {
                                        Image(systemName: "globe")
                                            .foregroundStyle(.tint)
                                        
                                        Text(tab.browserWebManager.title)
                                            .lineLimit(1)

                                        Spacer()
                                        
                                        Button {
                                            browserManager.destroyTab(tab: tab.id, in: group.id)
                                        } label: {
                                            Image(systemName: "xmark.circle")
                                                .foregroundStyle(.red)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                    .padding(.leading, 8)
                                    .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                
            } header: {
                Text("Tab Groups")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 6)
            }
        }
        .listStyle(.sidebar)
    }
}
