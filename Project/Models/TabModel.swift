//
//  TabModel.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import Foundation
import WebKit
import SwiftData

private func makeWebView() -> WKWebView {
    let configuration = WKWebViewConfiguration()

    let webView = WKWebView(
        frame: .zero,
        configuration: configuration
    )

    webView.customUserAgent =
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) " +
        "AppleWebKit/605.1.15 (KHTML, like Gecko) " +
        "Version/27.0 Safari/605.1.15"

    return webView
}

@Model
final class TabModel: Identifiable {
    var id = UUID()
    var title: String = "New Tab"
    var url: URL

    @Transient
    var webView: WKWebView = makeWebView()

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
    }
}
