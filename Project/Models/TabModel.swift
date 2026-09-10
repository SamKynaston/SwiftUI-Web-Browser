//
//  TabModel.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import Foundation
import WebKit
import SwiftData

@Model
final class TabModel: Identifiable {
    var id = UUID()
    var title: String = "New Tab"
    var url: URL

    @Transient
    var webView: WKWebView = WKWebView()

    @Transient
    var isLoading = false

    @Transient
    var loadingProgress = 0.0

    @Transient
    var canGoBack = false

    @Transient
    var canGoForward = false

    init(url: URL) {
        self.url = url
        self.webView = WKWebView()
    }
}
