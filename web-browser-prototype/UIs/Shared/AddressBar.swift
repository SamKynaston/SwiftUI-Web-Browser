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
    
    private var loadingProgress: Double {
        browserManager.activeTab?
            .browserWebManager
            .loadingProgress ?? 0
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
            .onChange(of: browserManager.activeTab?.browserWebManager.url) {
                text = browserManager.activeTab?.browserWebManager.url?.absoluteString ?? ""
            }
            .onChange(of: browserManager.activeTabId) {
                text =
                    browserManager.activeTab?.browserWebManager.url?.absoluteString
                    ?? browserManager.activeTab?.url.absoluteString
                    ?? ""
            }
            .onSubmit() {
                browserManager.activeTab?.browserWebManager.navigate(to: text)
            }
            
            Button {
                browserManager.reload()
            } label: {
                Image(systemName: "arrow.trianglehead.clockwise.rotate.90")
                    .foregroundColor(.gray)
            }
        }
        .clipShape(Capsule())
        .padding(.leading, 12)
        .overlay(alignment: .bottom) {
            GeometryReader { geometry in
                Rectangle()
                    .frame(
                        width: geometry.size.width * loadingProgress,
                        height: 2
                    )
                    .frame( maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading )
                    .allowsHitTesting(false)
            }
            .opacity(
                browserManager.activeTab?.browserWebManager.isLoading == true
                    ? 1
                    : 0
            )
        }
    }
}
