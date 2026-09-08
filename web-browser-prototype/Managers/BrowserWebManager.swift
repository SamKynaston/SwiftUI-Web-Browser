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
    var loadingProgress: Double = 0.0

    init(initialURL: URL? = nil) {
        self.url = initialURL
    }

    func navigate(to text: String) {
        var text = text.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        if !text.contains("www.") {
            text = "https://google.com/search?q=\(text)"
        } else if text.contains("www.") {
            if !text.contains("://") {
                text = "https://" + text
            }
        }
        
        guard let url = URL(string: text) else {
            return
        }
        
        webView?.load(URLRequest(url: url))
    }
    
    func refresh() {
        webView?.reload()
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
