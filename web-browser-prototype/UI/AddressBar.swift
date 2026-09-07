//
//  AddressBar.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI

struct AddressBar: View {
    @Bindable var browserManager: BrowserTabManager
    @State var text: String = ""

    init(browserManager: BrowserTabManager) {
        self.browserManager = browserManager

        let url = browserManager.activeTab?.browserWebManager.url
            ?? browserManager.activeTab?.url

        _text = State(
            initialValue: url?.absoluteString ?? ""
        )
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(
                "Search or enter website address",
                text: $text
            )
            .textFieldStyle(.plain)
            .multilineTextAlignment(.center)
            .onChange(of: browserManager.activeTabId) {
                text =
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
            .onSubmit() {
                navigate()
            }
        }
    }
    
    private func navigate() {
        var text = text.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if !text.contains("://") {
            text = "https://" + text
        }

        guard let url = URL(string: text) else {
            return
        }

        browserManager.activeTab?.browserWebManager.navigate(to: url)
    }
}
