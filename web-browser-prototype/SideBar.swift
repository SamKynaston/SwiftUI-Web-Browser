//
//  SideBar.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI

struct SideBarView: View {
    @Binding var selectedTabId: UUID?
    let tabs: [BrowserTab]
    
    var body: some View {
        List(selection: $selectedTabId) {
            ForEach(tabs) { tab in
                Text(tab.title)
                    .tag(tab.id as UUID?)
            }
        }
    }
}
