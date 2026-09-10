//
//  TabModel.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import Foundation
import WebKit

@Observable
final class TabModel: Identifiable {
    let id = UUID()
    let webView: WKWebView
    
    var title: String = "New Tab"
    var url: URL

    var isLoading = false
    var loadingProgress = 0.0
    var canGoBack = false
    var canGoForward = false

    init(url: URL) {
        self.url = url
        self.webView = WKWebView()
    }
}
