//
//  WebViewController.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    let url: URL
    let manager: BrowserWebManager
    
    func makeCoordinator() -> Coordinator {
        Coordinator(manager: manager)
    }
    
    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()

        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        
        manager.webView = webView
        
        return webView
    }
    
    func updateNSView(_ webView: WKWebView, context: Context) {
        guard webView.url != url else { return }
        webView.load(URLRequest(url: url))
    }
    
    final class Coordinator: NSObject, WKNavigationDelegate {
        let manager: BrowserWebManager

        init(manager: BrowserWebManager) {
            self.manager = manager
        }

        func webView(
            _ webView: WKWebView,
            didFinish navigation: WKNavigation?
        ) {
            manager.url = webView.url
            manager.title = webView.title
            manager.canGoBack = webView.canGoBack
            manager.canGoForward = webView.canGoForward
        }
    }
}
