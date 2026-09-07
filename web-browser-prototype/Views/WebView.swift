//
//  WebViewController.swift
//  web-browser-prototype
//
//  Created by Sam on 07/09/2026.
//

import SwiftUI
import WebKit

#if os(macOS)
typealias ViewRepresentable = NSViewRepresentable
#elseif os(iOS)
typealias ViewRepresentable = UIViewRepresentable
#endif

struct WebView: ViewRepresentable {
    let url: URL
    let manager: BrowserWebManager
    
    func makeCoordinator() -> Coordinator {
        Coordinator(manager: manager)
    }
    
    #if os(macOS)

    func makeNSView(context: Context) -> WKWebView {
        makeWebView(context: context)
    }

    func updateNSView(_ webView: WKWebView, context: Context) {
        updateWebView(webView)
    }

    #elseif os(iOS)

    func makeUIView(context: Context) -> WKWebView {
        makeWebView(context: context)
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        updateWebView(webView)
    }

    #endif
    
    private func makeWebView(context: Context) -> WKWebView {
        let webView = WKWebView()

        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))

        manager.webView = webView

        return webView
    }

    private func updateWebView(_ webView: WKWebView) {

    }
    
    final class Coordinator: NSObject, WKNavigationDelegate {
        let manager: BrowserWebManager

        init(manager: BrowserWebManager) {
            self.manager = manager
        }
        
        func webView(
            _ webView: WKWebView,
            didStartProvisionalNavigation navigation: WKNavigation?
        ) {
            manager.isLoading = true
            updateState(webView)
        }
        
        func webView(
            _ webView: WKWebView,
            didFinish navigation: WKNavigation?
        ) {
            manager.isLoading = false
            updateState(webView)
        }
        
        func webView(
            _ webView: WKWebView,
            didFail navigation: WKNavigation?,
            withError error: Error
        ) {
            manager.isLoading = false
            updateState(webView)
        }

        func webView(
            _ webView: WKWebView,
            didFailProvisionalNavigation navigation: WKNavigation?,
            withError error: Error
        ) {
            manager.isLoading = false
            updateState(webView)
        }

        private func updateState(_ webView: WKWebView) {
            manager.url = webView.url
            manager.title = webView.title ?? "New Tab"
            manager.canGoBack = webView.canGoBack
            manager.canGoForward = webView.canGoForward
        }
    }
}
