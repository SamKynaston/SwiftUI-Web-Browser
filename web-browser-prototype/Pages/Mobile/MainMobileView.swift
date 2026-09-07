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
        ZStack(alignment: .bottom) {
            webViews
            
            TextField(
                "Search or enter website address",
                text: $addressBarText
            )
            .frame(height: 52)
            .textFieldStyle(.plain)
            .multilineTextAlignment(.center)
            .glassEffect(.regular.interactive(), in: .capsule)
            .padding(.horizontal)
            .padding(.bottom, 16)
            .onChange(of: browserManager.activeTabId) {
                addressBarText =
                    browserManager.activeTab?.browserWebManager.url?.absoluteString
                    ?? browserManager.activeTab?.url.absoluteString
                    ?? ""
            }
            .gesture(
                DragGesture(minimumDistance: 20)
                    .onEnded { value in
                        let horizontalTranslation = value.translation.width
                        let threshold: CGFloat = 50

                        if horizontalTranslation < -threshold {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                browserManager.switchToNextTab()
                            }
                        } else if horizontalTranslation > threshold {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                browserManager.switchToPreviousTab()
                            }
                        }
                    }
            )
            .onSubmit(of: .search) {
                print($addressBarText)
            }
        }
        .ignoresSafeArea()
    }
    
    private var webViews: some View {
        GeometryReader { geometry in
            ForEach(browserManager.tabs) { tab in
                tabWebView(
                    tab: tab,
                    width: geometry.size.width,
                    height: geometry.size.height
                )
                .ignoresSafeArea()
            }
        }
    }
    
    private func tabWebView(
        tab: BrowserTab,
        width: CGFloat,
        height: CGFloat
    ) -> some View {
        WebView(
            url: tab.url,
            manager: tab.browserWebManager
        )
        .id(tab.id)
        .frame(width: width, height: height)
        .offset(
            x: tabOffset(
                tab: tab,
                width: width
            )
        )
    }

    private func tabOffset(
        tab: BrowserTab,
        width: CGFloat
    ) -> CGFloat {
        if tab.id == browserManager.activeTabId {
            return 0
        }

        if tab.id == browserManager.adjacentTabId {
            return browserManager.tabSwitchDirection > 0
                ? width
                : -width
        }

        return width * 2
    }
}
