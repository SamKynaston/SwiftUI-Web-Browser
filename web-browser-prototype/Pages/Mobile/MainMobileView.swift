//
//  MainMobileView.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI

struct MainMobileView: View {
    @Bindable var browserManager: BrowserTabManager
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Page(browserManager: browserManager)
                .ignoresSafeArea()
            AddressBar(browserManager: browserManager)
                .frame(height: 52)
                .glassEffect(.regular.interactive(), in: .capsule)
                .padding(.bottom, 4)
                .padding(.horizontal, 8)
            
        }
    }
}
