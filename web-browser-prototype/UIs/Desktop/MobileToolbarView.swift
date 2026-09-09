//
//  MobileToolvarView.swift
//  web-browser-prototype
//
//  Created by Sam on 09/09/2026.
//

import SwiftUI
import WebKit

#if os(iOS)
struct MobileToolBarView: ToolbarContent {
    @Bindable var tabManager: TabManager

    var activeTab: TabModel? {
        tabManager.activeTab
    }
        
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            ControlButtons(tabManager: tabManager)
            
            Spacer()
            
            AddressBar(tabManager: tabManager)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "square.on.square")
            }
        }
    }
}
#endif
