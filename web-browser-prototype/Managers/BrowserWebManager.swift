//
//  BrowserWebManager.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import WebKit

@Observable
final class BrowserWebManager {
    var webView: WKWebView?

    var url: URL?
    var title: String = "New Tab"

    var canGoBack = false
    var canGoForward = false
    var isLoading = false

    func navigate(to url: URL) {
        webView?.load(URLRequest(url: url))
    }

    func goBack() {
        webView?.goBack()
    }

    func goForward() {
        webView?.goForward()
    }

    func reload() {
        webView?.reload()
    }

    func stop() {
        webView?.stopLoading()
    }
}
