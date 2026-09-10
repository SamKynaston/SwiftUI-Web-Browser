//
//  SideBarTabGroup.swift
//  web-browser-prototype
//
//  Created by Sam on 09/09/2026.
//

import SwiftUI

struct SideBarTabGroup: View {
    @Bindable var tabManager: TabManager
    let group: TabGroupModel
    
    var body: some View {
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
                    
                    /*Button {
                        tabManager.createTab(urlString: "https://google.com", in: group.id)
                    } label: {
                        Image(systemName: "plus.square")
                            .foregroundStyle(.tint)
                    }
                    .buttonStyle(.plain)*/
                }
            }
            .buttonStyle(.plain)
            .contextMenu {
                Button("Open new tab", role: .confirm) {
                    tabManager.createTab(urlString: "https://google.com", in: group)
                }
                Button("Delete group", role: .destructive) {
                    tabManager.destroyTabGroup(group)
                }
                Button("Close all tabs", role: .destructive) {
                    tabManager.destroyAllTabsInGroup(group)
                }
            }
        }
    }
}
