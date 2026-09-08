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
    
    var onNavigationChange: ((URL?, String) -> Void)?

    func navigate(to text: String) {
        var text = text.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let websiteRegex = try! Regex(#"^(https?://)?(www\.)?[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+(/.*)?$"#)
        
        if text.contains(websiteRegex) {
            if !text.contains("://") {
                text = "https://" + text
            }
        } else {
            let query = text.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) ?? text

            text = "https://www.google.com/search?q=\(query)"
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
