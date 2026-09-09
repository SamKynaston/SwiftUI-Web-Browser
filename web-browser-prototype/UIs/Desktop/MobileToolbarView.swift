//
//  MobileToolbarView.swift
//  web-browser-prototype
//
//  Created by Sam on 09/09/2026.
//

import SwiftUI
import WebKit

struct MobileToolbarView: ToolbarContent {
    @Bindable var tabManager: TabManager

    var activeTab: TabModel? {
        tabManager.activeTab
    }
    
    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            ControlGroup {
                Button {
                    tabManager.goBack()
                } label: {
                    Image(systemName: "chevron.backward")
                }
                .disabled(!tabManager.canGoBack)

                if tabManager.canGoForward {
                    Button {
                        tabManager.goForward()
                    } label: {
                        Image(systemName: "chevron.forward")
                    }
                    .disabled(!tabManager.canGoForward)
                }
            }
            
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
