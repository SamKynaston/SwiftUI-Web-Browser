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
                    VStack(spacing: 8) {
                        Button {
                            browserManager.selectGroup(group)
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "square.on.square")
                                    .foregroundStyle(.tint)

                                Text(group.name)
                                    .lineLimit(1)

                                Spacer()
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(.vertical, 2)
                        
                        if browserManager.activeGroupId == group.id {
                            ForEach(group.tabs) { tab in
                                Button {
                                    browserManager.selectTab(
                                        tab,
                                        in: group
                                    )
                                } label: {
                                    HStack(spacing: 8) {
                                        Image(systemName: "globe")
                                            .foregroundStyle(.tint)

                                        Text(tab.title)
                                            .lineLimit(1)

                                        Spacer()
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
            }
        }
        .listStyle(.sidebar)
    }
}
