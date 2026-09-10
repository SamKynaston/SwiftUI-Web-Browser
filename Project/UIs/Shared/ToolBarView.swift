//
//  WebToolbar.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI
import WebKit

struct ToolBarView: ToolbarContent {
    @Bindable var tabManager: TabManager
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var showSheet = false

    var activeTab: TabModel? {
        tabManager.activeTab
    }
    
    var body: some ToolbarContent {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            ToolbarItemGroup(placement: .bottomBar) {
                ControlButtons(tabManager: tabManager)

                Spacer()

                AddressBar(tabManager: tabManager)
                    .font(.system(size: 12))
                Spacer()

                Button {
                    showSheet = true
                } label: {
                    Image(systemName: "square.on.square")
                }
                .sheet(isPresented: $showSheet) {
                    TabSheetView(tabManager: tabManager)
                }
            }
        } else {
            ToolbarItemGroup(placement: .automatic) {
                ControlButtons(tabManager: tabManager)
            }

            ToolbarSpacer(.fixed)

            ToolbarItemGroup(placement: .automatic) {
                AddressBar(tabManager: tabManager)
            }

            ToolbarSpacer(.fixed)

            ToolbarItemGroup(placement: .automatic) {
                Button {
                } label: {
                    Image(systemName: "square.on.square")
                }
                
                Button {
                    tabManager.createTab()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        #else
        ToolbarItemGroup(placement: .automatic) {
            ControlButtons(tabManager: tabManager)

            Spacer()

            AddressBar(tabManager: tabManager)
                .frame(width: 350)
            
            Spacer()

            Button {
                tabManager.createTab()
            } label: {
                Image(systemName: "plus")
            }
        }
        #endif
    }
}
