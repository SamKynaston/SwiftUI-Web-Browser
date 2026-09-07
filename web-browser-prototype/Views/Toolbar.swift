//
//  WebToolbar.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI

struct ToolBarView: View {
    @Bindable var browserManager: BrowserManager
    
    var body: some View {
        Button("Back") {
            browserManager.goBack()
        }
        
        Button("Forward") {
            browserManager.goForward()
        }
    }
}
