//
//  BrowserWebManager.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import WebKit

final class BrowserWebManager {
    var webView: WKWebView?

    var url: URL?
    var title: String?
    var canGoBack = false
    var canGoForward = false
}
