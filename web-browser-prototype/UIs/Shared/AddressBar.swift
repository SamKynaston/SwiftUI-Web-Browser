//
//  AddressBar.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI

struct AddressBar: View {
    @Bindable var tabManager: TabManager
    @State var text: String = ""
    
    private var loadingProgress: Double {
        tabManager.loadingProgress
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
            .onChange(of: tabManager.activeTab?.url) {
                text = tabManager.activeTab?.url.absoluteString ?? ""
            }
            .onChange(of: tabManager.activeTabId) {
                text =
                    tabManager.activeTab?.url.absoluteString
                    ?? tabManager.activeTab?.url.absoluteString
                    ?? ""
            }
            .onSubmit() {
                tabManager.navigate(to: text)
            }
            
            Button {
                tabManager.reload()
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
                tabManager.isLoading == true
                    ? 1
                    : 0
            )
        }
    }
}
