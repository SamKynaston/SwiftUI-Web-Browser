//
//  SideBarTab.swift
//  web-browser-prototype
//
//  Created by Sam on 09/09/2026.
//

import SwiftUI

struct SideBarTab: View {
    @Bindable var tabManager: TabManager
    let group: TabGroupModel
    let tab: TabModel
    
    var body: some View {
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
                    tabManager.destroyTab(tab, in: group)
                } label: {
                    Image(systemName: "xmark.circle")
                        .foregroundStyle(.red)
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 8)
            .background {
                Capsule()
                .fill(
                    tabManager.activeTab?.id == tab.id
                    ? Color.accentColor.opacity(0.15)
                    : .clear
                )
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .contextMenu {
            Button("Delete Tab") {
                tabManager.destroyTab(tab, in: group)
            }
        }
    }
}
