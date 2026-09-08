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
        List(selection: $browserManager.activeTabId) {
            Section {
                ForEach(browserManager.tabs) { tab in
                    HStack {
                        Text(tab.title)
                            .lineLimit(1)
                        
                        Spacer()
                        
                        Button {
                            destroyTab(tab)
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.small)
                        }
                        .buttonStyle(.plain)
                        .foregroundStyle(.secondary)
                    }
                    .tag(tab.id as UUID?)
                }
                .onMove { source, destination in
                    browserManager.tabs.move(
                        fromOffsets: source,
                        toOffset: destination
                    )
                }
            } header: {
                HStack {
                    Button {
                        browserManager.createTab(title: "Default", urlString: "https://google.com")
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.plain)
                    
                    Text("Tabs")
                        .font(.headline)
                }
            }
        }
    }
    
    private func destroyTab(_ tab: TabModel) {
        if let index = browserManager.tabs.firstIndex(where: { $0.id == tab.id }) {
            browserManager.destroyTab(at: IndexSet(integer: index))
        }
    }
}
