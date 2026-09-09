//
//  AddressBar.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI

struct AddressBar: View {
    @Bindable var browserManager: TabManager
    @State var text: String = ""

    init(browserManager: TabManager) {
        self.browserManager = browserManager

        let url = browserManager.activeTab?.url
            ?? browserManager.activeTab?.url

        _text = State(
            initialValue: url?.absoluteString ?? ""
        )
    }
    
    private var loadingProgress: Double {
        browserManager.loadingProgress
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
            .onChange(of: browserManager.activeTab?.url) {
                text = browserManager.activeTab?.url.absoluteString ?? ""
            }
            .onChange(of: browserManager.activeTabId) {
                text =
                    browserManager.activeTab?.url.absoluteString
                    ?? browserManager.activeTab?.url.absoluteString
                    ?? ""
            }
            .onSubmit() {
                browserManager.navigate(to: text)
            }
            
            Button {
                browserManager.reload()
            } label: {
                Image(systemName: "arrow.trianglehead.clockwise.rotate.90")
                    .foregroundColor(.gray)
            }
            .buttonStyle(.plain)
        }
        .clipShape(Capsule())
        .padding(.horizontal, 12)
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
                browserManager.isLoading == true
                    ? 1
                    : 0
            )
        }
    }
}
