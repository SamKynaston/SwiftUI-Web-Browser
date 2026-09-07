//
//  MainMobileView.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI

struct MainMobileView: View {
    @Bindable var browserManager: BrowserTabManager
    @State var addressBarText: String = ""

    init(browserManager: BrowserTabManager) {
        self.browserManager = browserManager

        let url = browserManager.activeTab?.browserWebManager.url
            ?? browserManager.activeTab?.url

        _addressBarText = State(
            initialValue: url?.absoluteString ?? ""
        )
    }
    
    var body: some View {
        let activeTab = browserManager.activeTab
        
        NavigationStack {
            if let activeTab {
                WebView(
                    url: activeTab.url,
                    manager: activeTab.browserWebManager
                )
                .id(activeTab.id)
                .ignoresSafeArea()
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            let threshold: CGFloat = 80

                            if value.translation.width < -threshold {
                                browserManager.switchToNextTab()
                            } else if value.translation.width > threshold {
                                browserManager.switchToPreviousTab()
                            }
                        }
                )
            }
        }
        .searchable(
            text: $addressBarText,
            prompt: "Search or enter website address"
        )
        .onSubmit(of: .search) {
            print($addressBarText)
        }
    }
}
