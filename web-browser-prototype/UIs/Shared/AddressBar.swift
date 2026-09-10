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
        tabManager.activeTab?.loadingProgress ?? 0
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(
                "Search or enter website address",
                text: $text
            )
            .foregroundColor(.gray)
            .textFieldStyle(.plain)
            .onChange(of: tabManager.activeTab?.title) {
                text = tabManager.activeTab?.url.absoluteString ?? ""
            }
            .onChange(of: tabManager.activeTab?.url) {
                text = tabManager.activeTab?.url.absoluteString ?? ""
            }
            .onSubmit {
                tabManager.navigate(to: text)
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
                tabManager.activeTab?.isLoading == true
                    ? 1
                    : 0
            )
        }
        .padding(.horizontal)
    }
}
